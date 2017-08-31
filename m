From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Thu, 31 Aug 2017 14:37:26 +0100
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
References: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708292315050.5428@hadrien>
 <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
 <20170829221532.ukkaxuvcgr7d25cn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708300722580.2152@hadrien>
 <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
 <20170830125059.eqlq4w54oz57azum@eos.mistotebe.net>
 <alpine.DEB.2.20.1708301504210.3184@hadrien>
 <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
Message-ID: <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 30, 2017 at 03:05:04PM +0200, Julia Lawall wrote:
> On Wed, 30 Aug 2017, Ond?ej Kuzn?k wrote:
>> OK, I understand. I any case, the suggestion below has very few false
>> negatives and no false positives that I could find, thanks a lot!
>>
>> The only false negatives are related to macro expansion, which probably
>> ties into the same limitation. It's strings like this:
>>
>> "string" BACKSQL_IDFMT "rest of string"
>>
>> Where BACKSQL_IDFMT is "%llu" or similar. Given how few of these there
>> are and that there have been no false positives from that that I could
>> see, I'm happy.
> 
> Maybe if you put this macro in with the others, then it will find it.

I already have, but I guess the Ocaml code doesn't have access to the
expanded version.

Moving onto the next step, I'm having problems with coccinelle rejecting
some patches for reasons I don't understand. For example it throws an
error applying the patch below even though some other files are fine and
the file in question parses fine without having to pass a builtin macro
file.

The patch tries to merge an snprintf and Debug if Debug is the only
consumer of that buffer plus removes the LogTest and buffer declaration
if appropriate.

This is the error I get on the file:

-----8<------
HANDLING: servers/slapd/back-asyncmeta/bind.c
     
previous modification:
MINUS
  >>> Debug(L, merged, args_before, args, args_after);

According to environment 10:
   shortcut.p1 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1865,2),(1865,10))]
   shortcut.p2 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1867,2),(1867,7))]
   shortcut_process.merged -> id "### %s asyncmeta_search_dobind_init[%d] mc=%p ld=%p rc=%d\n"
   shortcut_replace.args_after -> <<exprlist>>
   shortcut_replace.args_before -> <<exprlist>>
   shortcut_replace.L -> LDAP_DEBUG_ANY
   shortcut_replace.args -> <<exprlist>>
   shortcut.p1 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1865,2),(1865,10))]
   shortcut.p2 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1867,2),(1867,7))]
   shortcut_process.merged -> id "### %s asyncmeta_search_dobind_init[%d] mc=%p ld=%p rc=%d\n"

current modification:
MINUS
According to environment 9:
   shortcut.p1 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1865,2),(1865,10))]
   shortcut.p2 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1867,2),(1867,7))]
   shortcut_process.merged -> id "### %s asyncmeta_search_dobind_init[%d] mc=%p ld=%p rc=%d\n"
   shortcut_replace.L -> LDAP_DEBUG_ANY
   shortcut_replace.args_before -> <<exprlist>>
   shortcut_replace.args_after -> <<exprlist>>
   shortcut.p1 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1865,2),(1865,10))]
   shortcut.p2 -> poss[(servers/slapd/back-asyncmeta/bind.c,asyncmeta_dobind_init,((1679,0),(1910,1)),(1867,2),(1867,7))]
   shortcut_process.merged -> id "### %s asyncmeta_search_dobind_init[%d] mc=%p ld=%p rc=%d\n"

shortcut_replace: already tagged token:
C code context
File "servers/slapd/back-asyncmeta/bind.c", line 1867, column 2, charpos = 45042
  around = 'Debug',
  whole content =               Debug( LDAP_DEBUG_ANY, "### %s %s\n",
-----8<------

The patch in question:

-----8<------
@initialize:python@
@@

#regex from https://stackoverflow.com/questions/30011379/how-can-i-parse-a-c-format-string-in-python
import re
fmtstring = '''\
(                                  # start of capture group 1
%                                  # literal "%"
(?:                                # first option
(?:[-+0 #]{0,5})                   # optional flags
(?:\d+|\*)?                        # width
(?:\.(?:\d+|\*))?                  # precision
(?:h|l|ll|w|I|I32|I64)?            # size
[cCdiouxXeEfgGaAnpsSZ]             # type
) |                                # OR
%%)                                # literal "%%"
'''

regex = re.compile(fmtstring, re.X)

def parse_format(f):
    return tuple((m.span(), m.group()) for m in
        regex.finditer(f))

def insert_at_pos(fmt, s, pos):
    formats = parse_format(fmt)
    span, format = formats[pos]
    acc = fmt[:span[0]]
    if s.startswith('"'):
        acc += s[1:]
    else:
        acc += '" '
        acc += s
    if acc.endswith('"'):
        acc = acc[:-1] + fmt[span[1]:]
    else:
        acc += ' "'
        acc += fmt[span[1]:]
    return acc

// covered by others but processing those can take hours on some files
@shortcut@
type T;
identifier buf;
expression I, E, L;
expression list args_before, args, args_after;
expression format1, format2;
position p1, p2;
@@

(
{
\( T buf = {...}; \| T buf = I; \| T buf; \)
snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );
}
|
{
\( T buf = {...}; \| T buf = I; \| T buf; \| \)
snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );
}
|
\( T buf = {...}; \| T buf = I; \| T buf; \| \)
snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );
)

@script:python shortcut_process@
format1 << shortcut.format1;
format2 << shortcut.format2;
args_before << shortcut.args_before;
merged;
@@

pos = len(args_before.elements)
coccinelle.merged = insert_at_pos(format2, format1, pos)

@shortcut_replace@
position shortcut.p1, shortcut.p2;
identifier shortcut_process.merged;

type T;
identifier buf;
expression I, E, L;
expression list args_before, args, args_after;
expression format1, format2;
@@

(
-{
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
-}
|
{
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
}
|
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug@p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
)

@useless_if@
expression L;
@@

-if ( LogTest( L ) ) {
 Debug( L, ... );
-}
-----8<------

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
