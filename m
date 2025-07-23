Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C46BC83F17
	for <cocci@archiver.kernel.org>; Wed, 23 Jul 2025 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mSXTi7TVW/j7HDCZsg/siofnVqmDtWFS8fS5/GQftbU=;
  b=FAbcFY4DRm4lHhzxOfVoYJTCQ/WC/ugwbye5ARJ1RxYQcQbm1hCjAmz+
   XKZ1P4K+YPdkWnu8/PTipLB53lXGu/IeluVuUbHNjrlwfN/eZWy5sqDOW
   FbDXHjpc4Cg1N055dVU6D0XLfYswyKttgApYMTbmU0HFLkAwpo7HDuWk7
   o=;
X-CSE-ConnectionGUID: bP8kUK5JSuaBMS4v40Ph0A==
X-CSE-MsgGUID: Est2954CSSuULlfH+5PmUQ==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,333,1744063200"; 
   d="scan'208";a="232738177"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jul 2025 09:45:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3465E0CD5; Wed, 23 Jul 2025 09:45:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C5304E0171
	for <cocci@sympa.inria.fr>; Wed, 23 Jul 2025 09:45:38 +0200 (CEST)
X-CSE-ConnectionGUID: dpNwZTr8TDeZlWOLPChS0A==
X-CSE-MsgGUID: 4IJR+DYjQ9q6NoRe6YUZlQ==
IronPort-SDR: 68809322_KnqUryjgiHJdRP8Eqqs7hYWyFmNYHpEEyDd/SRWO5ip4bBx
 +5nxfejZ0Ix3DyCfpc7vhsweX++qWJofH6XGZ0Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HqBABvkoBogAwR49RaH2qBU4JEgQAGVDMEC0kEhFGPU?=
 =?us-ascii?q?IZfhymQX4NSAg8BAwENRAoBAgQBAQMENwGBVIJ0jBYCHgcBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg06RicEGQEBESYBNAImAiJPAgEBgn4BgiEBBhABA?=
 =?us-ascii?q?zIHDbAufzOBAYIMAQEGgmnXdR8sIlmBZAMGgRsuhW2CRgQaAQVtiHeBIQ+BV?=
 =?us-ascii?q?USBFSeBFIRMgnGDDoJpgiaBFoNlhBKEPIQ3iB+BShwDWSwBVRMXCwcFgWMDg?=
 =?us-ascii?q?Q9uMh2BJ4QKgQ6EJytPhRBBWINTJG0PBoEYgyJAAgELbT03CQsbBj2TAIRgg?=
 =?us-ascii?q?QCBSJMxgxWbCJNYTT00B4I4gWcFgV8MiQiBJpU9BhMvl1IOBpMFmQaMDoF6l?=
 =?us-ascii?q?V6FWYF+JIFcMxokgzYTPAMZD44tFoQRhGC7bEE1AgE5AgcBCgEBAwmFRgEBi?=
 =?us-ascii?q?WuBSwEB?=
IronPort-PHdr: A9a23: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
 HsmT7hGSBoqG/lcBkk3RLQ/
IronPort-Data: A9a23:uPBcM696xpjlWnZ+fRHeDrUDR3qTJUtcMsCJ2f8bNWPcYEJGY0x3n
 2QaW2qDMv+PazTwKdt+bY+w90gEsJXUzYcxSwVoqi9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNtcpvlDs15K6v4GxC5ARlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTiPn8Sp8o6hGtVAi/YnE+7PBKgfgSlJmGSx4fYOGfgvQo3P4sJEmig9jIZCEJ4yZ
 eJDMGApNk6fJUQQfA5NYH49tL/Aan3XVjRCq0+O44cz7XLSygNZz7XndtbYEjCPbZwPxxfJ9
 ziaogwVBDlGFf6liha08Ev9n7Hpmhn2BrMvJrmBo6sCbFq7nTBDUEZGCjNXu8KRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKywqBIHc2ciQRVPArhssJYhgS/
 V+yx/q8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvYiLTGYb0UunczpzLJNZmOEZDhnc7
 li3QMUWgrIOkYgU2q/98V2vb9OQSnrhHl5dCub/BzzNAuZFiGiNOdXABb/zs6woEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AEyRMN5pm3wqyD6Lei8BQ2Swm82ba7onhe2P
 yfuVf95ucMDbBNGkIcsMtvgUJpCIVbIT464DK68giVyjmhZL1PXpHo+OiZ8Lkjsl04riukkN
 P+mnTWEXR4n5VBc5GPuHY81iOd1rghnnD+7bc6hk3yPj+DADFbLEu1tGAXVMYgEAFas+lW9H
 yB3bZvSk003vSyXSnW/zLP/2nhacSFjXMun850/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 iDjBB1r2xDkiGfZKA6HTHlmZfm9Fdx8tH83d2hkd1qhx3FpM87l4bY9ZqkHW+At1NVi6vpoE
 NgDWcGLWcpURhr9pj8yUJjara5ZTiqNuz6gBSSfXWUAT8ZSfDCRot7AVSnzxRYKFRuy5Jcfo
 aX/9wb1QqgjZgVFDeSNWs2O0mGegHk5s8BxVnvuPdN8VhjN8o9rCiqpld4xAZgGBivizwug9
 TS9IEknt8zShbQq4f/1hayghKW4IdtUR0Z1MTHS0uerCHP84GGm/75lbM+JWjLsDEXP56SoY
 LRu/cHWafEosg5DjNthLuxN06k72trIoo1axCRCGFHgTQyiKpFkE0m88fh/jI9/7Z4HhlLuQ
 WOKwMdQBpuRMsC8EFIxGhssXt7e6d4qwAvt/dYHC2SkwhRo/Yi3c1RYZDiNry1/EIFbEq0Yx
 cUZhcpHzDDn1zQLNI6dgzF25la8CCUKc58au6EwBK7pjQsWyW9+X6HMNx+u4L+zRoVNFmIIP
 g6rgLHzguUA50jaLFs2O3v//ctcopUspBoR8gcmIViNq9uYhc0M/QZw9A4vRV9/1SR30ONUO
 0lqOXZqJK6IwSxauchbU02oGCBDHBe86GWr73csi0viUFiOamzBCEYfKNS91hkV3EwEdwcK4
 YzC7njuVAjbWf3Y3wwwaBZDkOPiR9kgzT/yspmrMOrdFqZrfAe/pLGlYFcJjB7VAckRoknjj
 ssy9cZSbZzLDwIhk5cZOaK7i4tJEAulIVZcS85P5KkKRGHQWA+j0Ai0dnyeRJl/GOzow2SZV
 epVOcN9Zzav3n2vrxcaJ5I2DZ1aofoL3OcGK5TXfTMokr3HtTd4koPixg6njk8Rftheu8IcK
 ITQSjG8LlKtlUZkw2/gkc0VFVe7MP8lZRL91t+b6O8mNYwOm8AyfFAQ0ombhWS0Mgxm80iqv
 SfGXav3zvNj+6tojYDDAqVOPCTqCNLRBcCj0hG/jMRKVvzLafzxjgIyrkL1GihrJp4TZohHr
 quMu9vJw0/1hrY6fGTHkZ2nFaMSx8GNcMdIE8Dwdl92oDCjXZLy3h495GyIE5xFv9dD7M2BR
 QHjSs+Rd8YQauhN1k9udClSPBYMOZvZNp66i3uGkM2NLRwB3SjsDtCtrybpZF4GUB44AcT1D
 wustsu+4txdkp93OyYFIPNbGL59Hk7oXPo3Vt/2tATANFKSvHG5huLAmyYjuBbxMVvVIPait
 NiBDlL7eQ+psa7F8MBBvsYg9lcLBXJ6mq8rclhb59dyjCugAXUbKfgGd68LEYxQjje4waSQi
 Osht4f+IX6VsfV4nRTADBDLWwCCGqoRN92/KjFBE4Z4rcupLNvoPVej3n4ID7RKlv/L0+ytb
 90TkpE1Fgbk2YlnHI7/+dTi6dqKBZrmKrYg5k331cD/a/rb7XPmy1Q5dDdwuef7/w0hWakFy
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:bBVuLqsyJ3ju01fQxHhM9mLa7skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: 9a23:zoG8T2y3/AOs8YoFy/zdBgUYAuY6QEHHnEv8Ln28NkFNcJaVcge5rfY=
X-Talos-MUID: 9a23:bdKJjgsxKM2KohealM2n2BBADoRE0qaXWVlTt5I8tpe1CB50AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,333,1744063200"; 
   d="scan'208";a="121999245"
X-MGA-submission: =?us-ascii?q?MDG6kXV4P3WUj3RByxx10eMZDqmVTCzlq7MioR?=
 =?us-ascii?q?hCvZ0BNHrgL32BrjpvfEfU9aezGAsS1OphgSqtwVx8K465+w6dahKdOE?=
 =?us-ascii?q?CAGBPpVxy+bl5xM14+YHmoNrCtYZCKRmJgUW0cKWTFdRZUkkU4WnJjlf?=
 =?us-ascii?q?syYlqtvXYWLBbnTwZB+VDseg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 09:45:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753256736; x=1753861536; i=markus.elfring@web.de;
	bh=mSXTi7TVW/j7HDCZsg/siofnVqmDtWFS8fS5/GQftbU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nDh2ubx451nSFGrLJcK0U6njK4DYPavRSYM3DkVHXzpF46++iQWZg2hbWGZGuVIT
	 A9tBEqQasKcOFLr+hi2iZrWf1uky+h8dH3vS2UwEw5nPO6oIcw9hA9uUyR/b2c3Rw
	 zzUSCZAUtf1A1t9HSBKwSyUeaA3f0zbMFbyog+tThS6TXBPh/4+nmtkvV6xqhxZCb
	 242nP8zLttTzEs28fJWvrxB0jX9bhSoCDRE55v6avVhzheoap9P3c1DgMcJh++4BD
	 4XEoOP11r7QakuU4XPmlJk/y8Q3l2+uDUCaAPtcH0YT1q7ixaIbXWiqBDLJu002W1
	 AF8tC/S+AwEf/rQSJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sBp-1ueAZT2rwl-00xYmt; Wed, 23
 Jul 2025 09:45:36 +0200
Message-ID: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Date: Wed, 23 Jul 2025 09:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Erick Karanja <karanja99erick@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n12skXYiQlvyfj6ITAMGUBvJ+KzIjpWINBVSJ8S0faCs8fwkmWh
 dPbJmau8PvaJBbPOlySWv2bJOVx7A8z67CI8yhAPv/+sLaHKU+nYnppcS7TloiIFQ4tGheJ
 TodnfZ/womMOuVlksWvHDftQ79NE33OrL0v4YGwjrDNoI6GDloAHu32n0mqT5I9HyDPWozf
 fNOYBdjovqwh5+THPb05w==
UI-OutboundReport: notjunk:1;M01:P0:1oxK+amC7/4=;YXkVIU4vC9DJmcUNjZSOXmjWOmG
 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
 0x5dSaeLxDw==
Subject: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2902
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/6daf83a9-abbf-45f7-b82e-c6207364fd8b%40web.de>

Hello,

I noticed another contribution.

I got into the mood to construct another script for the semantic patch lan=
guage.


// See also:
// [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
// https://lore.kernel.org/linux-sound/20250721114554.1666104-1-karanja99e=
rick@gmail.com/
@display@
expression x, y;
@@
*mutex_lock(x);
 ...
*mutex_lock(y);
 <+...
*mutex_unlock(x);
 ...
*mutex_unlock(y);
 ...+>


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250722 && time /usr/bin/spatch --no-loops =E2=80=A6/Projekte/Coccin=
elle/janitor/show_questionable_unlock_call_order.cocci sound/usb/qcom/qc_a=
udio_offload.c
=E2=80=A6
@@ -1580,7 +1576,6 @@ static void handle_uaudio_stream_req(str
                goto response;
        }
=20
-       mutex_lock(&chip->mutex);
        if (req_msg->enable) {
                if (info_idx < 0 || chip->system_suspend || subs->opened) =
{
                        ret =3D -EBUSY;
@@ -1613,9 +1608,7 @@ static void handle_uaudio_stream_req(str
                        ret =3D prepare_qmi_response(subs, req_msg, &resp,
                                                   info_idx);
                if (ret < 0) {
-                       mutex_lock(&chip->mutex);
                        subs->opened =3D 0;
-                       mutex_unlock(&chip->mutex);
                }
        } else {
                info =3D &uadev[pcm_card_num].info[info_idx];
@@ -1646,9 +1639,7 @@ static void handle_uaudio_stream_req(str
                }
=20
                disable_audio_stream(subs);
-               mutex_lock(&chip->mutex);
                subs->opened =3D 0;
-               mutex_unlock(&chip->mutex);
        }
=20
 response:
@@ -1662,7 +1653,6 @@ response:
                if (atomic_read(&uadev[pcm_card_num].in_use))
                        kref_put(&uadev[pcm_card_num].kref,
                                 uaudio_dev_release);
-               mutex_unlock(&chip->mutex);
        }
        mutex_unlock(&qdev_mutex);
=20
=E2=80=A6
real    0m0,501s
user    0m0,460s
sys     0m0,035s


Now I wonder how these diff hunks fit to my source code search approach
for finding call pairs of known functions (or macros).
Will another clarification become more interesting?

Regards,
Markus
