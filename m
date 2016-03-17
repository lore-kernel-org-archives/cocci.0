From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Mar 2016 06:33:01 +0100 (CET)
Subject: [Cocci] [cocci: new build warnings]: next-20160316
	setup_timer.cocci
In-Reply-To: <56E9F4F8.70708@ti.com>
References: <56E9F4F8.70708@ti.com>
Message-ID: <alpine.DEB.2.02.1603170632450.2301@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 16 Mar 2016, Nishanth Menon wrote:

> Hi,
> 
> It looks like commit c5eda8fd10c6 ("Coccinelle: Add
> api/setup_timer.cocci") with spatch rev(1.0.4 latest)[1] generates
> warning [2]. I am using spatch from the latest git tree[3]

Thanks for the feedback.  We will look into it.

julia

> rule name: parse error:
>   File "./scripts/coccinelle/api/setup_timer.cocci", line 109, column 0,
> charpos = 1939
>   around = '(',
>   whole content = '(context || org || report)@'
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
