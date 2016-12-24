From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 24 Dec 2016 07:05:57 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <20161223231019.GA25609@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
 <20161221214425.GA2315@roeck-us.net>
 <alpine.DEB.2.20.1612221326060.14381@hadrien>
 <83039af2-7b45-8b1f-d842-85a70b71ba11@roeck-us.net>
 <alpine.DEB.2.20.1612221634440.7817@hadrien>
 <20161222181948.GA20516@roeck-us.net>
 <alpine.DEB.2.20.1612231404050.4056@hadrien>
 <20161223231019.GA25609@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612240650400.2122@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 23 Dec 2016, Guenter Roeck wrote:

> Hi Julia,
>
> On Fri, Dec 23, 2016 at 04:54:41PM +0100, Julia Lawall wrote:
> [ ... ]
> >
> > // -------------------------------------------------------------------------
> > @ro@
> > declarer name SENSOR_DEVICE_ATTR, SENSOR_DEVICE_ATTR_2;
> > identifier x,show;
> > @@
> >
> > \(SENSOR_DEVICE_ATTR\|SENSOR_DEVICE_ATTR_2\)
> >         (x, \(0444\|S_IRUGO\), show, NULL, ...);
> >
>
> my version of spatch (?) does not like this construct.
>
> $ spatch --version
> spatch version 1.0.6-00036-gb62df17 compiled with OCaml version 4.02.3
> Flags passed to the configure script: --prefix=/usr
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> Is this something new, or am I doing something wrong ?

Something new, sorry.  I think it should be available in the github
version.  If not, the solution is just to split each case like this up
into two rules.

> I played with it myself, and came up with the (less elegant) version
> below. It isn't perfect (it does not handle the function-in-macro case
> well), but it should give us a good comparison. Also, I might just get
> rid of at least some of those macros; they just obfuscate the code anyway.
>
> Thanks,
> Guenter
>
> ---
> @initialize:python@
> @@
>
> import re
>
> // -------------------------------------------------------------------------
> // Easy case
>
> @d@
> declarer name SENSOR_DEVICE_ATTR,SENSOR_DEVICE_ATTR_2;
> identifier x,show,store;
> expression p;
> @@
>
> (
>   SENSOR_DEVICE_ATTR(x,p,show,store,...);
> |
>   SENSOR_DEVICE_ATTR_2(x,p,show,store,...);
> )
>
> @script:python expected@
> show << d.show;
> store << d.store;
> x_show;
> x_store;
> func;
> @@
> coccinelle.func = re.sub('show_|get_|_show|_get|_read', '', show)
> coccinelle.x_show = re.sub('show_|get_|_show|_get|_read', '', show) + "_show"
> coccinelle.x_store = re.sub('show_|get_|_get|_show|_read', '', show) +
"_store"
>
> if show == "NULL":
>     coccinelle.x_store = re.sub('store_|set_|_set|_store|_write|_reset', '', store) + "_store"
>     coccinelle.func = re.sub('store_|set_|_store|_set|_write|_reset', '', store)

OK, so you solve the incompatability between show and store by jut taking
the show version.  There could be some danger that another call will only
have the same store function and will rename it in a different way.  That
is:

SENSOR_DEVICE_ATTR(x, opt, get_one, set_two, 0)

will rename set_two to one_store, and

SENSOR_DEVICE_ATTR(x, opt, NULL, set_two, 0)

will rename set_two to two_store.

Otherwise, it seems fine.  It is better than my version in that it chooses
the new names all at once.  My version chose the new names for eg the WO
and RW cases after the RO case, so it had to protect against rechanging
names that it had already changed.  I also protect against renaming a name
being used in a DEVICE_ATTR call.  I don't know if that can happen.

You don't actually havce to repeat the declarer name declaration in every
rule.  Once you have specified that once, it is valid forever.  New
versions of Coccinelle allow the redeclaration, butold versions will
break.

julia


> @@
> declarer name SENSOR_DEVICE_ATTR_RO;
> identifier d.x,expected.x_show,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL, e);
> + SENSOR_DEVICE_ATTR_RO(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_WO;
> identifier d.x,expected.x_store,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store, e);
> + SENSOR_DEVICE_ATTR_WO(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_RW;
> identifier d.x,expected.x_show,expected.x_store,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\), x_show, x_store, e);
> + SENSOR_DEVICE_ATTR_RW(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_RO;
> identifier d.x,expected.x_show,expected.func;
> expression e1,e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0444\|S_IRUGO\), x_show, NULL, e1, e2);
> + SENSOR_DEVICE_ATTR_2_RO(x, func, e1, e2);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_WO;
> identifier d.x,expected.x_store,expected.func;
> expression e1,e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0200\|S_IWUSR\), NULL, x_store, e1, e2);
> + SENSOR_DEVICE_ATTR_2_WO(x, func, e1, e2);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_RW;
> identifier d.x,expected.x_show,expected.x_store,expected.func;
> expression e1, e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\), x_show, x_store, e1, e2);
> + SENSOR_DEVICE_ATTR_2_RW(x, func, e1, e2);
>
> // -------------------------------------------------------------------------
> // Other calls
>
> @o@
> declarer name SENSOR_DEVICE_ATTR,SENSOR_DEVICE_ATTR_2;
> identifier d.x,show,store;
> expression list es;
> @@
>
> (
> SENSOR_DEVICE_ATTR(x,\(0444\|S_IRUGO\|0200\|S_IWUSR\|0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\),show,store,es);
> |
> SENSOR_DEVICE_ATTR_2(x,\(0444\|S_IRUGO\|0200\|S_IWUSR\|0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\),show,store,es);
> )
>
> // rename functions
>
> @show1@
> identifier o.show,expected.x_show;
> parameter list ps;
> @@
>
> static
> - show(ps)
> + x_show(ps)
>   { ... }
>
> @depends on show1@
> identifier o.show,expected.x_show;
> expression list es;
> @@
> - show(es)
> + x_show(es)
>
> @depends on show1@
> identifier o.show,expected.x_show;
> @@
> - show
> + x_show
>
> @store1@
> identifier o.store,expected.x_store;
> parameter list ps;
> @@
>
> static
> - store(ps)
> + x_store(ps)
>   { ... }
>
> @depends on store1@
> identifier o.store,expected.x_store;
> expression list es;
> @@
> - store(es)
> + x_store(es)
>
> @depends on store1@
> identifier o.store,expected.x_store;
> @@
> - store
> + x_store
>
> // try again
>
> @@
> declarer name SENSOR_DEVICE_ATTR_RO;
> identifier d.x,expected.x_show,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL, e);
> + SENSOR_DEVICE_ATTR_RO(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_WO;
> identifier d.x,expected.x_store,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store, e);
> + SENSOR_DEVICE_ATTR_WO(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_RW;
> identifier d.x,expected.x_show,expected.x_store,expected.func;
> expression e;
> @@
>
> - SENSOR_DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\), x_show, x_store, e);
> + SENSOR_DEVICE_ATTR_RW(x, func, e);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_RO;
> identifier d.x,expected.x_show,expected.func;
> expression e1,e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0444\|S_IRUGO\), x_show, NULL, e1, e2);
> + SENSOR_DEVICE_ATTR_2_RO(x, func, e1, e2);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_WO;
> identifier d.x,expected.x_store,expected.func;
> expression e1, e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0200\|S_IWUSR\), NULL, x_store, e1, e2);
> + SENSOR_DEVICE_ATTR_2_WO(x, func, e1, e2);
>
> @@
> declarer name SENSOR_DEVICE_ATTR_2_RW;
> identifier d.x,expected.x_show,expected.x_store,expected.func;
> expression e1, e2;
> @@
>
> - SENSOR_DEVICE_ATTR_2(x, \(0644\|S_IRUGO|S_IWUSR\|S_IWUSR|S_IRUGO\), x_show, x_store, e1, e2);
> + SENSOR_DEVICE_ATTR_2_RW(x, func, e1, e2);
>
