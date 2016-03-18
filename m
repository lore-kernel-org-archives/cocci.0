From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Mar 2016 11:22:48 +0100 (CET)
Subject: [Cocci] [cocci: new build warnings]: next-20160316
	setup_timer.cocci
In-Reply-To: <56E9F4F8.70708@ti.com>
References: <56E9F4F8.70708@ti.com>
Message-ID: <alpine.DEB.2.10.1603181108000.2581@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Mar 2016, Nishanth Menon wrote:

> Hi,
>
> It looks like commit c5eda8fd10c6 ("Coccinelle: Add
> api/setup_timer.cocci") with spatch rev(1.0.4 latest)[1] generates
> warning [2]. I am using spatch from the latest git tree[3]
>
> rule name: parse error:
>   File "./scripts/coccinelle/api/setup_timer.cocci", line 109, column 0,
> charpos = 1939
>   around = '(',
>   whole content = '(context || org || report)@'


Thanks again for the report.  The problem is just the newline before the
(, whch causes the ( to be differently interpreted (for a disjunction).
There is no need for such an interpretation in this position in the code,
so I have updated Coccinelle.  The update should be in github by the end
of the day.

Probably we should submit a patch on the semantic patch to add a space in
front of the offending parentheses, to make the rule usable with all
versions.

julia

>
> [1]
> spatch byte-code version 1.0.4-00203-gdb45d7549bdd compiled with OCaml
> version 4.01.0
> Flags passed to the configure script: [none]
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> [2] http://pastebin.ubuntu.com/15405226/
> [3] https://github.com/coccinelle/coccinelle.git
>
> --
> Regards,
> Nishanth Menon
>
