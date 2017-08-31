From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Thu, 31 Aug 2017 16:46:34 +0100
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <WM!dd59490e5b7de329073fb77c10065fccac3a9a41edb3acd8e86e03476c313ec5bb332d1b5b82bbc9f3c9941991f2c2e3!@mailstronghold-1.zmailcloud.com>
References: <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
 <20170829221532.ukkaxuvcgr7d25cn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708300722580.2152@hadrien>
 <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
 <20170830125059.eqlq4w54oz57azum@eos.mistotebe.net>
 <alpine.DEB.2.20.1708301504210.3184@hadrien>
 <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
 <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311602290.6822@hadrien>
 <WM!dd59490e5b7de329073fb77c10065fccac3a9a41edb3acd8e86e03476c313ec5bb332d1b5b82bbc9f3c9941991f2c2e3!@mailstronghold-1.zmailcloud.com>
Message-ID: <20170831154634.apai7ml2mdrf7ua4@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 31, 2017 at 04:09:30PM +0200, Julia Lawall wrote:
> The problem is in the rule shortcut_replace.  You have:
> 
> [...]
> 
> There are three case (1, 2, and 3).  Normally a disjunction like this
> matches from top to bottom, ie if the first case matches the ohers are not
> considered.  Here however the patterns don' all start matching at the same
> node.  The first two do, ie at an {, but the third does not.  So the third
> will match over top of what was matched by the previous ones.  So there
> will b multiple matches, and Coccinelle would prefer to do nothing rather
> than to do something inconsistent.
> 
> As far as I can see, there is no real difference between the cases.  It
> could probably be easier to just put the third case, and then have some
> other rules to clean up any kinds of {} that occur.

Yes, that has worked quite well actually. It has caused one problem,
though, splitting it up has made coccinelle strip curly brackets all
over the place, which is a bit problematic in places like this:

if (...) {
    /* comment */
    Debug( ... );
}

turning it into something very hard to read, especially if there is an
else branch:

if (...)
    /* comment */
    Debug( ... );

So far, nothing I've tried has helped limiting this, those include:
- pinning it on "+Debug at p3" which coccinelle rejects.
- using the below, probably because of your observation above
(
 if (...) {
     Debug(...);
 }
|
-{
 Debug(...);
-}
)
- the above but splitting that in two rules and a remembered location

The current patch I'm using is:
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

// covered by others but processing that can take hours on some files
@shortcut@
identifier buf;
expression E, L;
expression list args_before, args, args_after;
expression format1, format2;
position p1, p2;
@@

snprintf at p1( buf, E, format1, args );
Debug at p2( L, format2, args_before, buf, args_after );

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

identifier buf;
expression E, L;
expression list args_before, args, args_after;
expression format1, format2;
@@

-snprintf at p1( buf, E, format1, args );
-Debug@p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );

@@
type T;
initializer I;
@@
{
-\( T buf = I; \| T buf; \)
 Debug( ... );
}

@@
@@
-{
 Debug( ... );
-}

@useless_if@
expression L;
@@

-if ( LogTest( L ) ) {
 Debug( L, ... );
-}
-----8<------

> I think that it should also be possible to define a metavariable
> 
> initializer i;
> 
> And then replace
> 
> T buf = {...}; \| T buf = I;
> 
> by T buf = i;

That does work, thanks.

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
