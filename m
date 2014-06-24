From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 24 Jun 2014 15:06:47 -0700
Subject: [Cocci] SmPL for automatic request_firmware_nowait() conversion
In-Reply-To: <20140624215828.GA14124@electric-eye.fr.zoreil.com>
References: <20140621015714.GX4841@wotan.suse.de>
 <20140621105205.GA31611@electric-eye.fr.zoreil.com>
 <20140623232107.GB27687@wotan.suse.de>
 <20140624215828.GA14124@electric-eye.fr.zoreil.com>
Message-ID: <CAB=NE6Xz6V20fQfMq8HtmdA2ATUpFnOyLHK5W+OvLCj9Ce9+Vg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 24, 2014 at 2:58 PM, Francois Romieu <romieu@fr.zoreil.com> wrote:
> Thanks for the pointers.
>
> I can't help thinking that there's a bit of sensationalism in the
> timeout * num CPUs argument though. :o)

Indeed, this actually only applies to microcode which will end up
using the API for each CPU it seems.

  Luis
