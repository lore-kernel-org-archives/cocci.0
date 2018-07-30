From: timur@kernel.org (Timur Tabi)
Date: Mon, 30 Jul 2018 15:27:35 -0500
Subject: [Cocci] Removing trailing whitespace at the end of changes
	lines?
In-Reply-To: <alpine.DEB.2.20.1807302220180.3269@hadrien>
References: <CAOZdJXWdvdkEc1qrbsONSu77NuMpFWpCi-hMycjS5CaGikk6+A@mail.gmail.com>
 <alpine.DEB.2.20.1807302220180.3269@hadrien>
Message-ID: <CAOZdJXVRmHE3ZPpRuXCqdsmjdp0uBFTJdwoB-Gs6rHCwucHpCQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 30, 2018 at 3:21 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Coccinelle makes some special efforts to add newlines to respect the 80
> character boundary.  It seems that the associated space is not always
> getting removed.  I will try to take a look.

It appears to happen only when the second parameter is on the second
line.  That is, the LEVEL_xxx parameter is the only parameter on the
first line.
