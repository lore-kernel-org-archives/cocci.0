From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Tue, 1 Sep 2015 13:28:27 -0400
Subject: [Cocci] [RFC] firmware: annotate thou shalt not request fw on
	init or probe
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CA+5PVA6toGj5iboTgK5Casy9vUAQC8SXYWKEx+ojwC51UEV0HA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Aug 28, 2015 at 9:18 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> We are phasing out the usermode helper from the kernel,
> systemd already ripped support for this a while ago, the
> only remaining valid user is the Dell rbu driver. The

Actually, I don't think that is accurate any longer.  The Dell rbu
driver certainly requires this, but it seems that the following
drivers select FW_LOADER_USER_HELPER_FALLBACK as well:

CONFIG_DRM_STI
CONFIG_LEDS_LP55XX_COMMON

Why they do that, I have no idea.  It's kind of disappointing.

josh
