From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 09:25:12 -0700
Subject: [Cocci] bundles/pycaml/: force pycaml preparation to be done
	serially
In-Reply-To: <a273d1e4-143d-9850-940b-8f1ccf8c7fa6@users.sourceforge.net>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de>
 <20160617223327.GX11948@wotan.suse.de>
 <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
 <20160620221839.GL25646@wotan.suse.de>
 <a273d1e4-143d-9850-940b-8f1ccf8c7fa6@users.sourceforge.net>
Message-ID: <CAB=NE6VhQ-4c6U740w6q+yCghBQMp0ces8f3B=wnq18hQLptrw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 21, 2016 at 9:22 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> ?, the only consistent fix seems to be to use
>> .NOTPARALLEL on all bundles.
>
> How do you think about a bit more fine-tuning for this setting?
>
> Would you really like to switch parallelisation off for the affected make scripts completely?

Building should work, period. Optimizations to building can be done,
but since parallel building is brokena and something fixes it, that
should be consdered first as it at least fixes general parallel
building. The disabling of parallel building here is just for the
prepare target.

  Luis
