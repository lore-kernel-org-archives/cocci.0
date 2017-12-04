From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Dec 2017 15:58:51 +0100 (CET)
Subject: [Cocci] Recursive matches / returning lists from scripting code
 back to coccinelle
In-Reply-To: <1de60b4045fc4ec69bfea4838b6ce16a@konrad-technologies.de>
References: <80bb156f70ad4db195a386716dadfef6@konrad-technologies.de>,
 <alpine.DEB.2.20.1711291217460.3214@hadrien>
 <1de60b4045fc4ec69bfea4838b6ce16a@konrad-technologies.de>
Message-ID: <alpine.DEB.2.20.1712041556361.3129@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 4 Dec 2017, Pesth Florian wrote:

> Von: Julia Lawall <julia.lawall@lip6.fr>
> Gesendet: Mittwoch, 29. November 2017 12:21
>
> > Look at demos/iteration.cocci.? This is discussed in "Advanced SmPL" at
> > http://coccinelle.lip6.fr/papers.php.
>
> Thanks, this seems to be exactly what I need! However demos/iteration.cocci and demos/python_iteration.cocci should do the same with ocaml and python respectively, or is there a difference? With demos/iteration.cocci, I get a match on
>
> ...
> Skipping: demos/interprocedural_adhoc.c
> 1 pending new file instances
> 0 pending original file instances
>
> HANDLING: demos/python_iteration.c
> 1 pending new file instances
> 0 pending original file instances
>
> HANDLING: demos/python_iteration.c
> * TODO [[view:demos/python_iteration.c::face=ovl-face1::linb=11::colb=4::cole=5][def demos/python_iteration.c::11]]
> [[view:demos/python_iteration.c::face=ovl-face2::linb=12::colb=4::cole=5][ref]]
>
> but with demos/python_iteration.cocci I don't get a match:
>
> ...
> Skipping: demos/interprocedural_adhoc.c
> 1 pending new file instances
> 0 pending original file instances
>
> HANDLING: demos/python_iteration.c
> 1 pending new file instances
> 0 pending original file instances
>
> No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci or check whether any virtual rules (e.g., after_start) should be defined.

I have this behavior too.  Could you live with the OCaml version in the
short term?  You only have to use OCaml when calling add_if_not_present.
You can write python scripts if you need to do other things.


>
> This was tested with the latest git code on OpenSuse and Ubuntu:
>
> spatch version 1.0.6-00362-gce2ea2c compiled with OCaml version 4.02.3
> Flags passed to the configure script: --prefix=/home/v6000d/ --disable-parmap
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> BTW on Ubuntu (16.04.2 LTS) I had some problems compiling coccinelle which could be solved by adding "--disable-parmap" to the configure script. Is this a known issue? I did not need to add this option on OpenSuse.

No, it's not a known issue.  Do you have a parmap that was compiled
with a different version of OCaml?

julia

> > ... There is no way to create several environments from a single
> > invocation of a script rule.? All you can do is extend the existing
> > environment that caused the rule to be executed in the first place.
> > ... [solution with global list]
>
> Thanks, if iteration works as above this will already be sufficient for me at the moment. Thanks a lot for your help!
>
> Best regards,
> Florian Pesth
>
