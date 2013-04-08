From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Mon, 08 Apr 2013 16:29:35 +0200
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <mailman.1.1364983201.25969.cocci@systeme.lip6.fr>
References: <mailman.1.1364983201.25969.cocci@systeme.lip6.fr>
Message-ID: <1365431375.3314.42.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If this may help, I stumbled against the same error in a different
setting, but I think the ultimate cause is the same:

$ cat in.c
int foo()
{
  register rI;
  return rI;
}

$ cat in.cocci
@f1@
identifier f;
position p;
type T;
@@
* T at p f;

The reported error is the same: << Fatal error: exception Failure("empty
list, max_min_ii_by_pos") >>
I localized the problem on the variable declaration <<register rI;>>
where the type is missing (int by default). As soon as you add the
missing "int", the error disappears. 
In fact, the error seems somewhat justified, as you are taking the
position of an inexistent type.

I guess that in the big file indicated by Markus, the problematic
declaration is:


> static DEFINE_PER_CPU(unsigned long, cpu_loops_per_jiffy) = { 0 };


where we have the same missing, implicit int return type.

Hope it helps,
Nic.

On Wed, 2013-04-03 at 12:00 +0200, cocci-request at systeme.lip6.fr wrote:

> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Tue, 02 Apr 2013 17:37:30 +0200
> From: SF Markus Elfring <elfring@users.sourceforge.net>



> Would you like to reproduce my issue with the following SmPL filter pattern on
> the source file
> "https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/init/calibrate.c?id=8595c539f0360477189eef91f6337ba44962f72d"?



> ------------------------------
> 
> Message: 3
> Date: Tue, 2 Apr 2013 18:21:22 +0200 (CEST)
> From: Julia Lawall <julia.lawall@lip6.fr>



> I get the problem on the following code:
> 
> irqreturn_t
> nouveau_irq_handler(DRM_IRQ_ARGS)
> {
>         struct drm_device *dev = arg;
>         struct nouveau_device *device = nouveau_dev(dev);
>         struct nouveau_mc *pmc = nouveau_mc(device);
>         u32 stat;
> 
>         stat = nv_rd32(device, 0x000100);
>         if (stat == 0 || stat == ~0)
>                 return IRQ_NONE;
> 
>         nv_subdev(pmc)->intr(nv_subdev(pmc));
>         return IRQ_HANDLED;
> }
> 
> I would suspect that there is some inconsistency in how it is parsing this
> kind of argument list.  It seems to parse it OK, but then not be able to
> match it against a pattern like ...,x,...  I can look at it in more detail
> tomorrow.
> 
> julia
> 


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130408/f4c99e4b/attachment.html>
