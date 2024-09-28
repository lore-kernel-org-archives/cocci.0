Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A51CF6493
	for <cocci@archiver.kernel.org>; Sat, 28 Sep 2024 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bBTc+m1Lybiyd2jhJYJNaZ5Lw5ag2OiShGThL+GdPIM=;
  b=cbfp+8huktVE9s3OIc3gOWJyUACf8wjq2oHfdiby65huxj0cVpadjNg3
   GDv2VRCnAMIYXMJ0yuSsoiODifS56T4+9KGj4CXqDP6J16iXtaGzeQCgG
   uMyR5EL6DrThIn9w+9vVe08ILBfcr1g/X+1FC4f9DO9727QVJejWgwlSp
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,162,1725314400"; 
   d="scan'208";a="185704477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2024 21:57:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02B85E0145; Sat, 28 Sep 2024 21:57:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D6CCBE0035
	for <cocci@sympa.inria.fr>; Sat, 28 Sep 2024 21:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bBTc+m1Lybiyd2jhJYJNaZ5Lw5ag2OiShGThL+GdPIM=;
  b=bVL/az2hsDakpF1H4iD8VzZlWf/Nk36DeJv5VvzvLXz6Vg69n6Sh+i90
   6fbP2HXyexD7bJ+aEq0Q6SgPDa6swlHPE9OoYR1rMtSFzEyw1SO5mEwVP
   udypdzQJvtXfSwczx+hzbfdFBWg58FTeMBEqAqVoVfhxxpHuMhOnQk86k
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,162,1725314400"; 
   d="scan'208";a="97673628"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 21:57:56 +0200
Date: Sat, 28 Sep 2024 21:57:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20240911010927.741343-1-lihongbo22@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2409282157330.11896@hadrien>
References: <20240911010927.741343-1-lihongbo22@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -next v3 00/10] coccinelle: Add some rules for
 string_chioces helpers.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1896
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409282157330.11896%40hadrien>



On Wed, 11 Sep 2024, Hongbo Li wrote:

> We found that many of the detection rules for helpers in
> string_choices.h are missing. This series of patches is
> intended to complete these rules. We have verified in the
> latest kernel tree that these rules can detect many places
> where the string choices helper can be used as a replacement.
>

Thanks.  Applied.

julia



> Here are some of the examples:
>
> ```
> drivers/gpio/gpio-mvebu.c:917:6-18: opportunity for str_lo_hi(in_pol & msk)
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1109:16-19: opportunity for str_high_low(val)
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1116:13-16: opportunity for str_high_low(val
> drivers/gpio/gpio-wcove.c:396:6-16: opportunity for str_hi_lo(ctli & 0x1)
> drivers/pci/hotplug/pnv_php.c:367:10-41: opportunity for str_on_off(state == OPAL_PCI_SLOT_POWER_ON)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1844:40-63: opportunity for str_read_write(edu_cmd == EDU_CMD_READ)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1437:33-35: opportunity for str_on_off(wp)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1467:9-11: opportunity for str_on_off(wp)
> drivers/greybus/svc.c:76:9-37: opportunity for str_enabled_disabled(gb_svc_watchdog_enabled ( svc ))
> drivers/thermal/thermal_sysfs.c:59:29-36: opportunity for str_enabled_disabled(enabled)
> drivers/dma-buf/st-dma-fence.c:508:10-35: opportunity for str_yes_no(dma_fence_is_signaled ( f2 ))
> drivers/mmc/host/omap_hsmmc.c:1644:7-43: opportunity for str_enabled_disabled(host -> flags & HSMMC_SDIO_IRQ_ENABLED)
> drivers/input/mouse/elan_i2c_core.c:202:2-4: opportunity for str_on_off(on)
> drivers/macintosh/via-pmu.c:626:10-28: opportunity for str_enabled_disabled(option_server_mode)
> drivers/usb/mtu3/mtu3_debugfs.c:482:5-39: opportunity for str_on_off(regulator_is_enabled ( otg_sx -> vbus ))
> drivers/net/wireless/intel/iwlwifi/mvm/tt.c:355:4-10: opportunity for str_enable_disable(enable)
> drivers/nfc/pn544/i2c.c:215:7-20: opportunity for str_low_high(polarity == 0)
> drivers/media/tuners/tda18250.c:110:3-12: opportunity for str_true_false(triggered)
> drivers/mtd/tests/torturetest.c:191:30-35: opportunity for str_enabled_disabled(check)
> drivers/bus/intel-ixp4xx-eb.c:225:5-8: opportunity for str_enabled_disabled(val)
> drivers/net/ethernet/huawei/hinic/hinic_port.c:1133:3-9: opportunity for str_enable_disable(enable)
> drivers/net/ethernet/huawei/hinic/hinic_port.c:1245:3-9: opportunity for str_enable_disable(pfc_en)
> drivers/media/pci/cx23885/cimax2.c:227:4-8: opportunity for str_read_write(read)
> drivers/media/usb/em28xx/em28xx-video.c:941:4-9: opportunity for str_enabled_disabled(flags)
> ```
>
> Changes since v2: https://patchwork.kernel.org/project/linux-hardening/cover/20240904091451.3328272-1-lihongbo22@huawei.com/
>   - Remove unnecessary outer parentheses for new rules as suggested by julia, thanks.
>   - Remove unnecessary outer parentheses for old rules.
>
>
> Changes since v1: https://patchwork.kernel.org/project/linux-hardening/cover/20240829112455.232263-1-lihongbo22@huawei.com/
>   - Add more rules for helpers in string_choices.h.
>
> Thanks,
> Hongbo.
>
> Hongbo Li (10):
>   coccinelle: Add rules to find str_true_false() replacements
>   coccinelle: Add rules to find str_false_true() replacements
>   coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
>   coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
>   coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
>   coccinelle: Add rules to find str_read_write() replacements
>   coccinelle: Add rules to find str_write_read() replacements
>   coccinelle: Add rules to find str_on_off() replacements
>   coccinelle: Add rules to find str_yes_no() replacements
>   coccinelle: Remove unnecessary parentheses for only one possible
>     change.
>
>  scripts/coccinelle/api/string_choices.cocci | 240 +++++++++++++++++++-
>  1 file changed, 232 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
>
