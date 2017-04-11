From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 11 Apr 2017 20:42:33 +0200
Subject: [Cocci] [PATCH 1/2] firmware: Google VPD: import lib_vpd source
	files
In-Reply-To: <1491934554.17839.13.camel@perches.com>
References: <1491902071-17935-1-git-send-email-thierry.escande@collabora.com>
 <1491902071-17935-2-git-send-email-thierry.escande@collabora.com>
 <20170411140919.GC4388@kroah.com>
 <1491934554.17839.13.camel@perches.com>
Message-ID: <20170411184233.GB26792@kroah.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 11, 2017 at 11:15:54AM -0700, Joe Perches wrote:
> On Tue, 2017-04-11 at 16:09 +0200, Greg Kroah-Hartman wrote:
> > Care to use "real" kernel variable types please?  u8, u16, and others
> > are you friend, uint8_t really isn't what we prefer, and checkpatch
> > should tell you that...
> 
> checkpatch doesn't warn about "u?int\d+_t" types unless
> --strict is enabled and most likely it shouldn't.

For brand new drivers, it's a good thing to run, to keep maintainers
from complaining about obvious things :)

thanks,

greg k-h
