From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 4 Jul 2017 14:22:42 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291026390.2983@hadrien>
 <WM!fa141e32a0b1e5356bb136cefca80be54d02a269aa1d5e1c1d01b9dd1e9da14f2f9fffdc08676c298a48132a86f2037e!@mailstronghold-1.zmailcloud.com>
 <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291733320.2968@hadrien>
 <WM!a6114e049b67df39e40551cd95bf5d65e432ff2f8c0445b0273a6b12349ae6346924a09e4c027fdcc87febe26a5e6a4e!@mailstronghold-2.zmailcloud.com>
 <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
Message-ID: <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've just progressed a bit further on the format generation front, there
are some issues though.

With a sample file file like this (and the semantic patch at the end of
the post):

int main()
{
  char buf[BUFSIZ];
  snprintf( buf, sizeof(buf), "%d %s %d", 1, "a", 3+2 );
  Debug( LDAP_DEBUG_STATS, "%s: received %d responses from %s, how exciting!\n",
      __func__, 3, buf, extra_arg, extra_arg1, extra_arg3 );
}

Defining format1 as an expression makes python see '" % d   % s   % d "'
for some reason, what would be the reason for that? Defining it as a
format string changes that (and while python only sees a single string,
it is fine for now).

The main problem that is holding me up is that coccinelle fails with the
following error when trying to use the patch against the code above:
Fatal error: exception Common.Impossible(145)

Not sure what is happening there, and trying to replace merge in the '+'
line with "%@merged@" (with the change to its type) doesn't change that.

Thanks,
Ondrej

The semantic patch:
---------------- 8< ------- snip --------- 8< ---------------
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

@b exists@
expression E, L;
expression list args_before, args, args_after;
identifier buf;
format list format1, format2;
position p1, p2;
@@

snprintf at p1( buf, E, "%@format1@", args );
...
Debug@p2( L, "%@format2@", args_before, buf, args_after );

@script:python b_process@
format1 << b.format1;
format2 << b.format2;
args_before << b.args_before;
merged;
@@

pos = len(args_before.elements)
formats = parse_format(format2)

span, format = formats[pos]
merged = format2[:span[0]] + format1 + format2[span[1]:]
print "Merged '%s' into '%s' ->\n\t'%s'" % (format1, format2, merged)

coccinelle.merged = merged

@b_replace@
position b.p1, b.p2;
expression b_process.merged;

expression E, L;
expression list args_before, args, args_after;
identifier buf;
format list format1, format2;
@@

-snprintf at p1( buf, E, "%@format1@", args );
+Debug( L, merged, args_before, args, args_after );
...
-Debug at p2( L, "%@format2@", args_before, buf, args_after );
---------------- 8< ------- snip --------- 8< ---------------

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
