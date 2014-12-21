From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 21 Dec 2014 12:15:08 +0100 (CET)
Subject: [Cocci] how to debug missing match?
In-Reply-To: <20141221102055.GB1081@katana>
References: <20141221095337.GA1081@katana> <20141221102055.GB1081@katana>
Message-ID: <alpine.DEB.2.02.1412211214010.2068@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 21 Dec 2014, Wolfram Sang wrote:

> 
> > does not result in anything although three drivers should match IMO with
> > the same pattern as the pmu driver above. Both use
> > platform_driver_register() and both have the .owner field set.
> > 
> > drivers/macintosh/windfarm_pm112.c
> > drivers/macintosh/windfarm_pm72.c
> > drivers/macintosh/windfarm_rm31.c
> > 
> > How can I debug why the match does not occur?
> 
> So, I found "--verbose-parsing" to be helpful which gives me:
> 
> parse error 
>  = File "drivers/macintosh/windfarm_pm112.c", line 685, column 4, charpos = 17702
>     around = 'nr_cores', whole content = 		++nr_cores;
> 
> which basically means that it can't handle for_each_node_by_type()?
> 
> bad: 	for_each_node_by_type(cpu, "cpu")
> BAD:!!!!! 		++nr_cores;
> 
> But neither "--include include/linux/of.h" nor "--recursive-includes"
> does help the case for me?

Here is a patch (band-aid...).  It was made on rc23, but it should apply 
to rc22 just as well.

julia

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 2a665cd..58b7a14 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -324,6 +324,8 @@ let rec is_really_foreach xs =
     | TCPar _::Tfor _::xs -> true, xs
     | TCPar _::Tswitch _::xs -> true, xs
     | TCPar _::Treturn _::xs -> true, xs
+    | TCPar _::TInc _::xs -> true, xs
+    | TCPar _::TDec _::xs -> true, xs
 
 
     | TCPar _::xs -> false, xs
