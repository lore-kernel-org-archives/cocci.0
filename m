From: chunkeey@googlemail.com (Christian Lamparter)
Date: Wed, 25 Jun 2014 03:10:02 +0200
Subject: [Cocci] [RESEND][PATCH 3/3] p54: use request_firmware_direct()
	for optional EEPROM override
In-Reply-To: <1403649583-12707-4-git-send-email-mcgrof@do-not-panic.com>
References: <1403649583-12707-1-git-send-email-mcgrof@do-not-panic.com>
 <1403649583-12707-4-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1582751.494RL7XPxB@blech>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tuesday, June 24, 2014 03:39:43 PM Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> The p54 driver uses request_firmware() twice, once for actual
> firmware and then another time for an optional user overide on
> EEPROM, 3826.eeprom. The custom EEPROM  is optional but if not
> present we'll introduce an extra lag of 60 seconds with udev
> present. Annotate we don't want udev nonsense here to avoid
> the lag in case its not present.
> [...]
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: linux-wireless at vger.kernel.org
> Cc: cocci at systeme.lip6.fr
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-By: Christian Lamparter <chunkeey@googlemail.com>
