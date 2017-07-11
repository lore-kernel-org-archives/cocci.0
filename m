From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 11 Jul 2017 15:25:44 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
References: <WM!3b412209b28e186e2cf1ceaaa46d40e6d1947012ed574b129f9c461a255f53e26f88920405ecdf4a7d052d70724bc64e!@mailstronghold-2.zmailcloud.com>
 <20170710161224.rbqo4drhcfqosh23@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101816540.1968@hadrien>
 <WM!18ce1dcc914ca4f9b61f6c3aaf891296df9651e3b4d79666e0682dd2ff392a761c732ee0cf4f6500e93b392f83991daf!@mailstronghold-1.zmailcloud.com>
 <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
 <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
 <alpine.DEB.2.20.1707111508220.2316@hadrien>
 <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
Message-ID: <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 11, 2017 at 03:10:36PM +0200, Julia Lawall wrote:
> On Tue, 11 Jul 2017, Ond?ej Kuzn?k wrote:
>> On Mon, Jul 10, 2017 at 07:26:36PM +0200, Julia Lawall wrote:
>>> Try running spatch --parse-c on your directory to get a list at the end of
>>> the top 10 things it doesn't like.
>>
>> One of the system dependent macros SLAP_EVENT_DECL is listed in each of
>> the 10 things. The macro is used in
>> https://github.com/openldap/openldap/blob/master/servers/slapd/daemon.c#L2343
>> to declare some variables used in the corresponding event loop.
>>
>> The macro definition looks like this:
>>
>> # define SLAP_EVENT_DECL		struct pollfd *revents
>>
>> or:
>>
>> # define SLAP_EVENT_DECL	fd_set readfds, writefds; char *rflags
>>
>> Ignoring this macro is OK I guess, if there is a way to do that with
>> coccinelle?
> 
> Just
> 
> #define SLAP_EVENT_DECL
> 
> in the .h file. But there will be stray ;s then.  So you might want to put
> the whole first definition.

It does seem to improve things, thanks. The line 2496 still doesn't
apply even when I declare SLAP_EVENT_FNAME to something like "name" in
-macro-file-builtins and I think there were similar ones in other files
later. 

>> Also, moving onto the other patch, I get similar inconsistencies with
>> ./servers/slapd/back-sql/add.c, --parse-c doesn't list any problematic
>> statements but the output logs a few parse errors that don't make much
>> sense to me.
> 
> Could you send the complete semantic patch that you are currently
> considering?  Then I can take a look.

Attaching the patches I'm currently working with:
(-macro-file-builtins macros.h)
1. variadic.cocci
2. shortcut.cocci
3. merge.cocci

The back-sql issue above is when trying to apply 2. (shortcut.cocci).
But the one I pasted in my last email is simple enough to illustrate the
issue (trying to merge snprintf and Debug, then get rid of extra if()s)
even without the python stuff.

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
-------------- next part --------------
A non-text attachment was scrubbed...
Name: macros.h
Type: text/x-chdr
Size: 106 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170711/3806a475/attachment.bin>
-------------- next part --------------
@@
identifier Logs =~ "Log[0-9]";
@@
-Logs
+Log

//identifier StatslogTest =~ "StatslogTest"; 
@@
@@
-StatslogTest
+LogTest

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0, 0
 );

@@
expression E, S;
@@

Debug( E, S
-, 0, 0, 0
 );

@@
format list[5] fmt;
expression list[5] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args );

@@
format list[4] fmt;
expression list[4] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0
 );

@@
format list[3] fmt;
expression list[3] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0
 );

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0, 0
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0, 0, 0
 );

@@
expression E, S;
@@

-Statslog
+Debug
 ( E, S
-, 0, 0, 0, 0, 0
 );

@@
identifier Stats =~ "^Statslog";
@@
(
 StatslogEtime
|
-Stats
+Debug
)
-------------- next part --------------
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

// covered by others but processing that can take hours on some files
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
\( T buf; \| T buf = I; \| \)
snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );
}
|
{
\( T buf; \| T buf = I; \| \)
snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );
}
)

@script:python shortcut_process@
format1 << shortcut.format1;
format2 << shortcut.format2;
args_before << shortcut.args_before;
merged;
@@

pos = len(args_before.elements)
formats = parse_format(format2)

span, format = formats[pos]
merged = format2[:span[0]] + format1.strip('"') + format2[span[1]:]

coccinelle.merged = merged

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
-\( T buf; \| T buf = I; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
-}
|
{
-\( T buf; \| T buf = I; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
}
)

@useless_if@
expression L;
@@

-if ( LogTest( L ) ) {
 Debug( L, ... );
-}
-------------- next part --------------
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

@a exists@
expression lock, E, L;
expression list args_before, args, args_after;
identifier buf;
expression format1, format2;
type T;
position p1, p2;
@@

{
...
T buf;
...
ldap_pvt_thread_mutex_lock(lock);
...
snprintf at p1( buf, E, format1, args );
...
ldap_pvt_thread_mutex_unlock(lock);
...
Debug at p2( L, format2, args_before, buf, args_after );
...
}

@script:python a_process@
format1 << a.format1;
format2 << a.format2;
args_before << a.args_before;
merged;
@@

pos = len(args_before.elements)
formats = parse_format(format2)

span, format = formats[pos]
merged = format2[:span[0]] + format1.strip('"') + format2[span[1]:]

coccinelle.merged = merged

@a_replace@
position a.p1, a.p2;
identifier a_process.merged;

expression lock, E, L;
expression list args_before, args, args_after;
identifier buf;
expression format1, format2;
type T;
@@

{
...
-T buf;
...
ldap_pvt_thread_mutex_lock(lock);
...
-snprintf at p1( buf, E, format1, args );
+Debug( L, merged, args_before, args, args_after );
...
ldap_pvt_thread_mutex_unlock(lock);
...
-Debug at p2( L, format2, args_before, buf, args_after );
...
}

@b exists@
expression E, L;
expression list args_before, args, args_after;
identifier buf;
expression format1, format2;
position p1, p2;
@@

snprintf at p1( buf, E, format1, args );
...
Debug at p2( L, format2, args_before, buf, args_after );

@script:python b_process@
format1 << b.format1;
format2 << b.format2;
args_before << b.args_before;
merged;
@@

pos = len(args_before.elements)
formats = parse_format(format2)

span, format = formats[pos]
merged = format2[:span[0]] + format1.strip('"') + format2[span[1]:]

coccinelle.merged = merged

@b_replace@
position b.p1, b.p2;
identifier b_process.merged;

expression E, L;
expression list args_before, args, args_after;
identifier buf;
expression format1, format2;
@@

-snprintf at p1( buf, E, format1, args );
+Debug( L, merged, args_before, args, args_after );
...
-Debug@p2( L, format2, args_before, buf, args_after );
