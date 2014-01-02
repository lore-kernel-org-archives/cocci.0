From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Jan 2014 10:33:12 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogtPC4tDogIGhpIGFsbCwgaG93IHRvIG1hdGNo?=
	=?gb2312?b?IHRoZSBhcmdzIGluIGZ1bmN0aW9u?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F488A@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401020939060.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F485B@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021014460.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F488A@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1401021024400.2182@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Jan 2014, ??(?? ??) wrote:

> Thank you very much, and
> I wrote as following which works now:
> 
> ------------
> @@
> identifier fn, vp;
> typedef bri_vlan_set_t;
> @@
> -fn(...,bri_vlan_set_t *vp,...)
> -{
> -...
> -}
> -------------
> 
> Now, here comes another problem, I want to find out those functions matching the prototype and memset vp in this function, for example
> 
> void vl_conbitmap(bri_vlan_set_t *vlanset) <-- condition 1
> {
>     if (action == BITMAP_EXCEPT) {
>         memset(vlanset, 0xff, sizeof(bri_vlan_set_t)); <-- condition2
>     }
> }
> 
> 
> How to write the patch?
> 
> I tried this:
> @@
> identifier fn, vp;
> typedef bri_vlan_set_t;
> expression e1,e2;
> @@
> -fn(...,bri_vlan_set_t *vp,...)
> -{
> -...
> -memset(vp, e1, e2);
> -...
> -}
> 
> But it seems failed, nothing output.

This means that every execution path has exactly one call to memset with 
vp as the first argument.  If you just mean that there should be at least 
one on every (non error) execution path, then you can put the following:

@@
identifier fn, vp;
typedef bri_vlan_set_t;
expression e1,e2;
@@
-fn(...,bri_vlan_set_t *vp,...)
-{
-<+...
-memset(vp, e1, e2);
-...+>
-}

If you want that there is at least one somewhere, with no constraints on 
the execution path, and you just want to find out about this, then you can 
put the following:

@@
identifier fn, vp;
typedef bri_vlan_set_t;
expression e1,e2;
@@
fn(...,bri_vlan_set_t *vp,...)
{
<+...
*memset(vp, e1, e2);
...+>
}  

* implicitly checks for the existence of such an execution path with the 
property, rather than requiring that all execution paths have the 
property.

If you really want to completely remove such functions, it is a bit more 
complicated.  First, you need the following rule, which explicitly uses 
exists, to find a fuction of interest:

@r exists@                    <----- new
identifier fn, vp;
typedef bri_vlan_set_t;
expression e1,e2;
position p;                   <----- new
@@
fn@p(...,bri_vlan_set_t *vp,...)  <----- new
{
<+...
memset(vp, e1, e2);
...+>
}  

And then the following rule, which considers all execution paths to 
remove the whole function:

@@
identifier r.fn;
position r.p;
@@

- fn at p(...) { ... }

The position variable is used to be sure that the second rule is matching 
the same function as the first one.  With ifdefs, you could have two 
definitions of functions with the same name.

julia

PS, please keep the mailing list in CC, as others could be interested in 
your question.
