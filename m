From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Nov 2017 09:21:11 +0900
Subject: [Cocci] [PATCH 2/2] scripts: coccinelle: api: detect identical
	chip data arrays
In-Reply-To: <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-10-09 4:18 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> within a single structure.  It is currently specific to the file
> drivers/power/supply/bq27xxx_battery.c.  Nevertheless, having the script in
> the kernel will allow others to check their code if the data structures
> change in the future.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Applied to linux-kbuild/misc.

-- 
Best Regards
Masahiro Yamada
