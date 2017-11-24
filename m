From: joe@perches.com (Joe Perches)
Date: Thu, 23 Nov 2017 16:25:37 -0800
Subject: [Cocci] [PATCH] net: usb: hso.c: remove unneeded DRIVER_LICENSE
	#define
In-Reply-To: <1511479801.5308.6.camel@perches.com>
References: <20171117141939.GD17880@kroah.com>
 <1511370336.6989.100.camel@perches.com> <20171122171201.GA6528@kroah.com>
 <1511479801.5308.6.camel@perches.com>
Message-ID: <1511483137.5308.8.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2017-11-23 at 15:30 -0800, Joe Perches wrote:
> --- /dev/null	2017-11-23 06:19:12.943046739 -0800
> +++ single_use_module.pl	2017-11-23 15:23:11.729812156 -0800
> @@ -0,0 +1,15 @@
[]
> +$data =~ s~$var~$string~;

this needs to be:

$data =~ s~\b$var\b~$string~;
