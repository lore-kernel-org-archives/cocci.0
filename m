Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776FEC77B73
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kTvgl/6SDODYSp1ERdltLFF/gWj0mDC0Lxtq2snn4DM=;
  b=drsoYCQ0KL0nq8VdXdmTTnKJBLn6elGeOCjzOJybIt4ZQh1xo2Wy2lck
   iPB7k3TVeyzhnXVZWheKLNjvQObp2cVgkDblZe+OXF718Jwv4a3zZFJQf
   rAPqC9MqeLwDuaE5svKZ1tloRK74nTuDIx9z1kJQRvSaDuKisp6bwqzwC
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="104011860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 16:26:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAF81E0269; Thu, 20 Apr 2023 16:26:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A76C9E019F
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 16:26:44 +0200 (CEST)
IronPort-SDR: 64414ba4_oC1bUxzA5eOicWI9XkSUcFgbPq5RGoAdOVU6BhAbAC7C4yy
 ULrNTPJQ6rlMW/+g351zeV+JFSCp6hM8ICGuq8g==
X-IPAS-Result: =?us-ascii?q?A0EIAADpSkFkhwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItgUsvBAtGhFORNoQwhy6HPoRnhAOBVhSBL?=
 =?us-ascii?q?D4PAQMBDUEBAgQBAQMEOIMzgRQChT0CHQcBBDEIDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDIx0BAREmAQ8fBgIRFQICVwYBDAgBA?=
 =?us-ascii?q?YJ6gigBAzEHqxGBMoEBgggBAQaCZJkoHywiVIFeCYEULQGNFIQwJw+BVUSBP?=
 =?us-ascii?q?INCg32BBoMcgmeCHpN2gTN0gSeBM4EEAgkCEWuBEAhogXNAAg1kCw5ugUVgR?=
 =?us-ascii?q?oFyBAIUQgwYBTUlBA4DGSsdQAIBCzs6PTUGAwsfBkQCJ4F/BIEIfAYBJiSYI?=
 =?us-ascii?q?AGBDZVOEZI1niA0B4IrgVaBWQyfDQYTL4NqE5MMDgaSJS6HMpAXIIIupVGBZ?=
 =?us-ascii?q?QE3gVwzGiRWggJeTwMZD44gGR6Dbo9IPzQ9AgcLAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23:8s62cK+j6NZ9+CYne6UwDrUDk3qTJUtcMsCJ2f8bNWPcYEJGY0x3y
 mYbXWGHaPmDYWPwfNBwPYni9RhQucTdm4MwTQdlqS9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f4nW8lWo4ow/jb8kg34K6q4GhwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEwM1xMlxnPdci0etaI1Fg/
 7sHMTJQcUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTuJkEtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QA9ArM/PpruAA/yiRDy5r2FoPuQuClatVEhle2/
 GHkpj32V0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZtrFQCOl8X7ehDURdvhgPed99xiPl7WBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7uz9pZW1qe/8kN+iBcQGBTJbO3RVHGPp9/G//thp03ojW/4+SPbdszHjJd3n6
 xauxMTUr4cek8MN3aih8l3B695HjsSWEFRdCun/eGW/8gMxTpSsbYWu9TDmARtoKYGEUh+es
 XJCl8X2AAEy4XOlxH3lrAYlRujBCxO53Nv03A8H834JqmXFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOtzhUpVwnPC6SIu6DJg4i+aihLAuK2drGwkxOiatM5zFyxhEfVwXZ
 MrLLJf1ZZrkIf02lmDtLwvi7VPb7nljmT2KHM6TI+WPiPTHLH+TVbofNlaSJuk2hJ5oUy2Fm
 +uzw/Cikk0FOMWnOne/2ddKcTgicCZnbbir9Z0/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVg4NOm3BMkl8StmVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNYkE
 KFXSNbKGflVVDXM9hIUaJS3/sQodw2miUjKd2CpaSQ2NcwoDQHY2M7WTi22/gk3Dw2zqZQfp
 Z+k3VjlWpYtfVlpI/vXT/ON9GmPm0Yhtth8ZGb2B+VCWV7N9dFqIhPhj/VsLMArLw7C9wSg1
 A2XIEk5oLDTr78M7dWTu6Ggqr2tMuphH3h1G3vQwqa2OBL7oEui495ke8SZcQ/NUFjb/P2ZW
 txU6PXnItgrrU1voaMlN5pKlIUQv8DOoZ1exSRaRET7VUyhUO5cEyPXzPtxub1o7Z4HnwmPA
 2ak2MRQYJeNM+PbSG8hHhIvNLm/5KtFiwvpzKoHJWvh73VK55uBa0JZOieMhAF7LLdYNIAEw
 /8riPUJ6j6Q2wYbDdKbsh96r2i8DGQMc6EChKEoBIXGjgkKyFYbb6fMVQ7wwpWEMOtXPmcQf
 zS7uavlhpZn/HTkTUYdL3b28NBmtcw8gywSlF4mDHaVq+XBnc4yjUFw8yxobwF7zSdn8uNUO
 0owBXJUOJehwjZMr+pAVlCKBAtuKkC4+Evw6l1Rj0zfbRCieVLsJV0HG9Sm3R4m4UdDWANE7
 ZekyGrBehT7TvHbhycddxZslK3+cIZX6AbHpvGCI+2EOJsLORzena6kYDszmSvNWM8eqhXOm
 rh3wbxWd6b+CC83pp87Aam80ZA7akiNBE5GcMFb0JI5J0PuUxDs5mHWMGG0QN1HGNLS+0zhC
 8BOGNNGZy7j6Amw9AIkFYw+CJ4qus5x/9cTWKLZFUhfuZulkzdZmpbx9C//uWwVf+tTgfsNc
 r32STbTPVGT1F11mnDMpvZqImCXQ8cJTyyi0fGX8NcmLYMisuZtfRsM05+xhXG0MRRmzT2Qr
 gjsd6/b9M086IVOzq/HMLRPOBWwEvz3DN+3yQGUt89cSP/yKuLMil8lkUbmNAFoIrchYdR7u
 rCTutrR3kmenrIJf03GupuGTY9l2N6TWbdJD8fJM3VqpyuOd8vy6R8l+WrjC5hokstY1/a3V
 TmDd8q8Wt4EaehznEQPRXBlLC8cLKDrYoPLhyC39a2MAydA9z33Foqs8HuxYFxLciMNBYbFN
 Tb1nPSQt+Bo9NEGQFdOAvx9GJZ3LWPyQaZsJZW7qTCcCXLumV+Y/KfrkR078zzQF32YC4DA7
 InYQgTlPgGH0E0SIAq1b6Qp1vHWMJp8vQX0Vkca5sIwlD2wSmILRQjY3VPqFbkM+hEeFrmhD
 N0OUIfmITrwV3JIfH0QJfz9CxyHCLVm1sjRf1QUEoD9V8tyLJyNCv1t+0+MJpuwliTLlImaF
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:Rj2/V643ZFOtCDJX2wPXwCTXdLJyesId70hD6qm+c20xTiX+rb
 HVoB17726OtN91YhsdcL+7WZVoLUm9yXdV2/hsAV7mZniAhILKFvAb0WKB+UyFJ8SWzIc0vp
 uIMZIObuEYa2IK7voSizPIaurIruP3kpyAtKP74zNEURxqApsN0y5JTiK2VmB/WQUuP/UEPa
 vZwuYChjakfx0sA/iTNz0gc6zinrTw+q4OGSR2eCLOemO1/EKVAenBYmalN2wlIk5y/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3AsGy0tWhdXN2qkK6kHszOVruEYjJucUXC8mqBIxW?=
 =?us-ascii?q?CImtEao27QxiP4aE5jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AO8n56w4U3fFnEaSe7maVISZlxoxa+Ia1Lhk2qak?=
 =?us-ascii?q?plNmVLT1eYTS/1W24F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="104011843"
X-MGA-submission: =?us-ascii?q?MDFpmTvvM0i+nBSpA38rdiRooYSnubEIalRHGK?=
 =?us-ascii?q?csqOMeGJTgwp5nOBVAgI4cNvXAMCGzXH9/vbN5UIBNO+9EFywrNHfaqi?=
 =?us-ascii?q?JjDTNjQ8xtbOQ7AuXoBcvW6Fn6q4Odma0xitW1B86Mocp9Fk47F9To9P?=
 =?us-ascii?q?XmRdrfoR3qKxrhoLrVyVQ3TA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682000802; i=markus.elfring@web.de;
	bh=mS96S/D3VxT1QwzkvJSRFzUdWylAm6eWxlYkrFWxbDA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=q55VJIgTpLpSlvMfA1hR0FM3Run/TUnL0SE0Uh9U1glgkjinfNia+yxeUsp643stw
	 ktaxQWfGSilllvXwXiCTaWkk5xX1bwVVMBO+8Nv1y+P+HJcmjV53IzeXxUxmIYf6Yt
	 vXDHLIam+lLQvdoU1MUqlcBBJRpWWzF7Nnr3KrwWD4byPC9JOOxJ/Kvwd2RXHp9amD
	 5vLA+pf3ApQ1BVh0/hQ6dFnIb0oJ1VD+kVN62JPJTqI3VD7zJrjvbTBjE1eUs77Suj
	 oNLcZ3K6uj9f+5Jk+ja71qemB2zYYsYD/1Rw1lPEkr386rYc/rjed3oDO2WG0ywsrE
	 pxZ/+BtCBLtzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mty5w-1qASwY2You-00uPgT; Thu, 20
 Apr 2023 16:26:42 +0200
Message-ID: <1f72786d-7ef2-80fa-58d2-98e379dd8ad7@web.de>
Date: Thu, 20 Apr 2023 16:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Emily Peri <eperi1024@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WrrfdeOS9UDeQKKM8UNcpzRNWrli/gIZw1b7/kMkbLtQ6Spubqs
 mMZWPHd4eHr2Opt+I9fGcOcbdI/N4ljB6kCW4vxM6gS9OvB7esW77RWDvRFHs7O9YTDdm50
 1wL8ghjms9PE+4s8upc/d9AKAKG4wardgroRTe4dnVDH/rTcFnn8HiM/ELCzkWEEHQW4SKe
 6nfeGMDonUDgge8rrFISQ==
UI-OutboundReport: notjunk:1;M01:P0:0nIB/MbAnIg=;g5KoQTBnU0cA5IFavBTr3yeO1EZ
 oCtjcC+eYdsxmOWGkRKh6l6HF/MTEig7BvMoKbAzObS7DXUPumj8WdwasMavhpI5uvYnnW6/P
 5kCTiPych1Z4tyS7rElSJDX8mzlIjQPzluouN8I6tjR/9+DmhIc75LyLMXaD/OKCbzUbTfgGD
 fEl52cXf+u66nGtC0DvG+CGbmA/OxVpn1nIIyUcoB9tCYg3E7PQLUN/yDoQ+YrY4NCxWrXo16
 f91mE8+X926rwYGl9BzeyUh/x1OyMWWT/SXiNhni5gVRygb8dpHkHeTFEcdPalOd0CVqi/smC
 ZJ3iZMkLRbb4fKwpaUSmQ8omkE29jgKFm+/d2YPcB47j1avhQ9LK4TWg0LUYk3e597OyCY0Bp
 wAJssGnUY9jKO3NNqHgCksDPneRaxdKVG9DgtitFJSMOY7oHTV3LEM34dNMGDCW56RyqcHt67
 fJBtKIRFYSvPBKhZFboED90qqDnCOK7d+vlDu5FpoPIuAoQsTaV9Gm+bjEeio0B3ru4cIM3PM
 S6Ic7/Ayn7gzrbwdQYtz4dYN+4rPvebgpSqWp6moXumj1GGEBUKtojZudb8a+GMbTsxetVjzB
 5Z8lmuuyjUtYAQgakPuYEC8Csq79Nz42CFu8+ek3g0LtS/U4wrPzPLtUuWckT3NUMMXHUiWXK
 Aibb8C/C+6Ea56OUG3zuq9wo92t9dkBUpr+1Rv5yNK4Vc3kd1cL+fuGV1xWSm2WdAU/+xRTYy
 fmZs5UMLjEdsH3CzZwzk9jysyJb58xBtbTT6Z+lMmky8dgiMShKi+oJD9Aifpo0ZxwbJqhI4R
 YdCo1B1EK4GsQHDTpOrrd/BEptcGwCZgGt9vvGhGR3HXKqi1Kr1Fy+CVYBWSZLuKYuhwdn5HT
 1oBXUCp07Zd0qlS8L3vmB7e6z27/Xb/3OQqwoFLUyG+I/movq9jK9vPZr
Subject: [cocci] [PATCH 0/4] staging: rtl8723bs: Adjustments for
 rtw_set_802_11_bssid_list_scan()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1104
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1f72786d-7ef2-80fa-58d2-98e379dd8ad7%40web.de>

Date: Thu, 20 Apr 2023 16:16:32 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete a null pointer check
  Return directly after a failed initialisation check
  Delete an unnecessary variable initialisation
  Move a variable assignment behind a condition check

 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

=2D-
2.40.0

