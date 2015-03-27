From: d.granat@samsung.com (Daniel Granat)
Date: Fri, 27 Mar 2015 11:32:16 +0100
Subject: [Cocci] [PATCH] Add coccinelle script that makes sure that
 tables are NULL terminated
In-Reply-To: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
Message-ID: <551531B0.4090108@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Could you please review my patch I sent last month? It checks if tables 
in kernel are NULL terminated. Script matches only names specified in 
source code by postfix='*_device_id$' and by list of prefixes which is 
now prefix_list = ['platform', 'of', 'i2c']. I think it could by useful 
in kernel sources.

On 02/27/2015 02:21 PM, Daniel Granat wrote:
> <pre wrap>
 > Signed-off-by: Daniel Granat &lt;d.granat at samsung.com&gt;
 > ---
 > scripts/coccinelle/misc/device_id_tables.cocci | 95 
++++++++++++++++++++++++++
 > 1 file changed, 95 insertions(+)
 > create mode 100644 scripts/coccinelle/misc/device_id_tables.cocci
 >
 > diff --git a/scripts/coccinelle/misc/device_id_tables.cocci 
b/scripts/coccinelle/misc/device_id_tables.cocci
 > new file mode 100644
 > index 0000000..5968984
 > --- /dev/null
 > +++ b/scripts/coccinelle/misc/device_id_tables.cocci
 > @@ -0,0 +1,95 @@
 > +/// Make sure '*_device_id$' tables are NULL terminated
 > +//
 > +// Keywords: device_id
 > +// Confidence: Medium
 > +// Options: --include-headers
 > +
 > +virtual org
 > +virtual report
 > +virtual patch
 > +
 > + at initialize:python@
 > +@@
 > +import re
 > +
 > +postfix = '_device_id$'
 > +prefix_list = ['platform', 'of', 'i2c']
 > +
 > + at r1 depends on patch || org || report@
 > +position p1;
 > +identifier var, arr;
 > +identifier struct_name;
 > +expression E;
 > +@@
 > +
 > +(
 > +struct struct_name arr[] = {
 > + ...,
 > + {
 > + .var = E,
 > + }
 > + @p1
 > +};
 > +|
 > +struct struct_name arr[] = {
 > + ...,
 > + { ..., var, ... },
 > + @p1
 > +};
 > +)
 > +
 > + at script:python depends on report@
 > +struct_name &lt;&lt; r1.struct_name;
 > +p1 &lt;&lt; r1.p1;
 > +arr &lt;&lt; r1.arr;
 > +pattern;
 > +@@
 > +
 > +for i in prefix_list:
 > + pattern = str(i)+postfix
 > + if re.match(pattern, struct_name) != None:
 > + print "\nCOCCI: \"%s\" matchs required pattern \"%s\"" % 
(struct_name, pattern)
 > + msg = "\"%s\" is not NULL terminated at line %s" % (arr, p1[0].line)
 > + coccilib.report.print_report(p1[0],msg)
 > + break
 > +
 > + at script:python match depends on patch@
 > +struct_name &lt;&lt; r1.struct_name;
 > +matched_name;
 > +pattern;
 > +@@
 > +
 > +coccinelle.matched_name = ''
 > +
 > +for i in prefix_list:
 > + pattern = str(i)+postfix
 > + if re.match(pattern, struct_name) != None:
 > + coccinelle.matched_name = struct_name
 > + break
 > +
 > + at r2 depends on patch@
 > +position r1.p1;
 > +identifier var, arr;
 > +identifier match.matched_name;
 > +expression E;
 > +@@
 > +
 > +(
 > +struct matched_name arr[] = {
 > + ...,
 > + {
 > + .var = E,
 > +- }
 > + @p1
 > ++ },
 > ++ {},
 > +};
 > +|
 > +struct matched_name arr[] = {
 > + ...,
 > + { ..., var, ... },
 > + @p1
 > ++ {},
 > +};
 > +)
 > +
 > </pre></body>
 > </html>
 > </html>
