Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25739C77B73
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BX7fgZ+QIqCDJCcw+5nKE0a0c1YwoNuFMz64wjqvdrU=;
  b=HzhBXLvz6pUDPjtOOdZWUdWCUZeWM7YigJmLPl3u+ZuT+DT+hfaMMsOz
   budYEt5B0zoz+Nnc/I8nQm8tBXuGb9SE3shthrDp5l2ttMMC7g+5N0sby
   5p7rtkWXgX/a0YjJxHDsPXIbyBBW/PtnDFCLcjR5rqdbnvA3f4ADkn2F/
   w=;
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
   d="scan'208";a="104012770"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 16:30:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 612ABE0269; Thu, 20 Apr 2023 16:30:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C66EFE01D1
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 16:30:24 +0200 (CEST)
IronPort-SDR: 64414c75_RbNmA+GeNS8Vjr07eVsknOgoKGaZt6/KnflRtWivNXsWvx/
 sK8r3E/A9S+o8inwJDxmVKxhB8HUmO720YN52jQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAD/S0Fkhw4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgTsEAQEBAQELAYItgUsvBAtGhFOIHYkZhDCHLoc+h?=
 =?us-ascii?q?GeEA4FWgUA+DwEDAQ1BAQIEAQEDBDiDM4EUAoU9Ah0HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkg?=
 =?us-ascii?q?QgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HA?=
 =?us-ascii?q?gJXBgEMBgIBAYJ6gigBAzEHqw9/M4EBgggBAQacDB8sIlSBXgmBFC0BjFU/g?=
 =?us-ascii?q?zZ6Jw+BVUSBPINCiB+CZ4IekzFFgTN0gSeBM4EEAgkCEWuBEAhoOIE7QAINZ?=
 =?us-ascii?q?AsOboFFYEaBcgQCFEIMGAU1JQQOAxkrHUACAQs7Oj01BgMLHwZEAieBWh8GB?=
 =?us-ascii?q?CRkfAYBJiSYIAGBDXIOgXaSWJJGniA0B4IrgVaBWQyfDQYTL5cJDgaSJS6HM?=
 =?us-ascii?q?pAXIKd/gWM6gVwzGiRWggJeTwMZD44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBh?=
 =?us-ascii?q?X0BAQ?=
IronPort-PHdr: A9a23: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
 PLmpZdEWVZzGv5IUyxY
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:koOWN6zitdu41BlADfK7KrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:ZIf9jm55Fe7a6HdxPdsszxckFuI7I0zmzUztGX+9BCUxUIecVgrF
X-Talos-MUID: 9a23:6YiWkgZ8v6Vq3uBTvBnyqB97bZpU2Ju+FGY1kIcUqtvaDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="53879292"
X-MGA-submission: =?us-ascii?q?MDFTykmzR/5R3KYNLWqZ2LWmpDISe0FNe0rFcv?=
 =?us-ascii?q?SPsYgjo6Mykh/7AL7Lm8LcWcSUH50vYEG0Rp3Uwsx9cYKpe96LbhU7xP?=
 =?us-ascii?q?6Wk25XXNtRWLtjZnrQWWTIUmT97yJuPmvhcLW54OmBI+wM8KnjS3ZF5R?=
 =?us-ascii?q?lLI22NmyNtmvEH/FDNcqGyNQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:30:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682001011; i=markus.elfring@web.de;
	bh=z+KZpoWWvEdh9etFvznA8aLGjPNzyCvihafs7DqVEuM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=lrFcH/F7SzsPJ5ttiiwEc7yaJSf52EgjDpd19P+eZU3/u6sEBU2sbuKKgQyuiwdmh
	 LGhZ0RmrnFpm6RnKNsh0dJGK2qktb3TEz174tyAOxkHOP9pnaFE9Ecx5dZGqKPvBeY
	 Ldxig+Lbq29zdq3MAKks1FyrnyD23Dg6Zmm3anWkKgMfz6vTCSvR6qeaxIaQt7/KHa
	 Pj6oZn6AhQhBfRPIyTGEK+cWWMVweRYpi5dkXE7kT9cKRaLkUcyUfvqbBHC+lkjBQj
	 LxlFFIDsISTec8P9PyuC/oX+j7gIYmBAK+qlnADdEd1ZPATxQu2ZOShjScbHFvZ8+W
	 fnqAm3CvZBMjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVKI-1q7iwD1yWQ-00riDe; Thu, 20
 Apr 2023 16:30:11 +0200
Message-ID: <f362cd27-21dd-fff5-729d-213c4d326457@web.de>
Date: Thu, 20 Apr 2023 16:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Emily Peri <eperi1024@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1f72786d-7ef2-80fa-58d2-98e379dd8ad7@web.de>
In-Reply-To: <1f72786d-7ef2-80fa-58d2-98e379dd8ad7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RaeZfTF0Y04sKU9uJMt6erzFJ/CKFECD9TvSuylZMsN9aG8fmeO
 cLq9bkfMU2ImMJ1ON7HGrwFJLqPU5BvJhFZHO1esUKlnH55rJI2888mwFJmzjOPCx6JiwVw
 JlwnhJQun0Xkha6CPB9+/2bdlB8ltCmwECrjmicHxEainhxrxr0qfU1yZoCAnlQ4Lq/AwsY
 409RI+7BYAKJd6eEocfhA==
UI-OutboundReport: notjunk:1;M01:P0:3rors8jRyW8=;M+dkLfGFLZj0tsWBnFI0BszFzMp
 1ww27KO5Ubigq6eWt/xfUt7C4pb8JfnGTOsBzblfC50fvAU+h1pYt1o3OS1pP+FvtuKU/awwW
 c9wSlH9Qlqa0oo/VRKe5GWxu7HdP9f6yXKVHINJRhB0t6ileei9dgAnBgzVbYR6y3eBorgOhV
 f/cldxJqwEFkWHtB2NZYcc+jgEyL0oE2n+FMY6nq9/t3vPUZY7+26fwm/2Nwn4lORdD5p2nbp
 RLxN0yKhlGhsyAkDwPievTkdYCcEktOyEVQpGwk7s59wbMtu6KGIkzxZNmU2EmfM20JecwtUd
 npu3VAHPkoABhbZfDtldebuoch6EAUm8wPAX9uKQFTZhVrO1hXvkVSOckCjbnwj1jpLWdZIJu
 4KxQNFTw4xejKGajXPAppkANXrbBwAmbr3p08y7vrOt/1fXKUTECYTyDSixtBbQ9CMhCPN+i3
 g76T7yPuqrOYi+MzDPx0GhzKq8CeofqT7CVF3x+rkDFl1hH1jqp2yPGkhg4e4ZU2GEstNKGa8
 E3K/mYqalwJj37QFZodgFUu1GVJOvlmZENjd76hUjBx18833FkaJtNSX2yC4UVpuqjiH8UfHZ
 6ZW4o2tb7sASH3tl/juJJNGzFz+U2a/nlLbqJgmbiLH3Az8awLoonrDwclvYsHWAjderVuXXg
 +0D+tj3GKD82l63hwxGNES4D+aW1Vzk3mTxIHfRqmQ32SEy/uX3fo0sBjdnw2GKYhZjZzTkjz
 Ixs5nj//4uu4ej91Gq621cr31o9m42SpJ0SfI6JbAjnSicAD6AOjkyL8n9W6hxw0mzKi0A/qr
 j0EQFIYh2GMeQRzSR9Apmu/WaoBrKdhvVWvt0BQev4dgS2BWpfjs3ersm6KYUKpjegg8ymliC
 A678qoHvJ0LbeKSH3cocmc8e30NELWnKhvk1PZhXhgNH0qd/6C2pMkZpr
Subject: [cocci] [PATCH 2/4] staging: rtl8723bs: Return directly after a
 failed initialisation check in rtw_set_802_11_bssid_list_scan()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1106
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f362cd27-21dd-fff5-729d-213c4d326457%40web.de>

Date: Thu, 20 Apr 2023 15:46:37 +0200

1. Return directly if the hardware initialisation was not completed so far=
.

2. Delete the label =E2=80=9Cexit=E2=80=9D which became unnecessary with t=
his refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/stag=
ing/rtl8723bs/core/rtw_ioctl_set.c
index 7c902f50d38b..0c2df854afe7 100644
=2D-- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -371,10 +371,8 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *pad=
apter, struct ndis_802_11_s
 	struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
 	u8 res =3D true;

-	if (padapter->hw_init_completed =3D=3D false) {
-		res =3D false;
-		goto exit;
-	}
+	if (!padapter->hw_init_completed)
+		return false;

 	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) =3D=3D=
 true) ||
 		(pmlmepriv->LinkDetectInfo.bBusyTraffic =3D=3D true)) {
@@ -391,8 +389,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *pada=
pter, struct ndis_802_11_s

 		spin_unlock_bh(&pmlmepriv->lock);
 	}
-exit:
-
 	return res;
 }

=2D-
2.40.0

