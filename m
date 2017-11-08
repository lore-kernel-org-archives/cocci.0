From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Nov 2017 21:04:17 +0800 (CST)
Subject: [Cocci] [PATCH 2/2] scripts: coccinelle: api: detect identical
 chip data arrays
In-Reply-To: <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711082104070.2708@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 7 Nov 2017, Masahiro Yamada wrote:

> 2017-10-09 4:18 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> > within a single structure.  It is currently specific to the file
> > drivers/power/supply/bq27xxx_battery.c.  Nevertheless, having the script in
> > the kernel will allow others to check their code if the data structures
> > change in the future.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
>
> Applied to linux-kbuild/misc.

Thanks!

julia
