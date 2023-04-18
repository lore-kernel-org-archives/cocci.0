Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C86C77B71
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KNuKdH7TLbEO7c63MUpE6Z95X2ZhhW9R3riMz2UcS4w=;
  b=p4/YmerqhJal6nuDJATXdpWDCW1aE5NjcpponTdH9H8TfPoGDrN4aSXt
   7AxNTBxQNPW5BBJtSTRYwq0uGZBMFxQXSxmL5DVGXREK+hGzdO6g+6EF+
   reb0Pdkw3HKJEV4R+LnrjXcLic4eumQnQ6wNjam0epmfQjJ7P7sNfolas
   k=;
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
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="103586073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 12:04:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41204E033A; Tue, 18 Apr 2023 12:04:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5299BE00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 12:04:33 +0200 (CEST)
IronPort-SDR: 643e6b30_D5xvTRmxrB7kijdqryK4vUTAMkY8aNq+Vah/fUbXBCWKjc7
 EQUAFpxLAyJH2T8yQgg4pxQx6yHcpfM/jPhd4Rw==
X-IPAS-Result: =?us-ascii?q?A0EgAADyaT5khw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPQQBAQELAYItgUsvBAtGhFORATGEMIcuhz6EZ4QDgVaBQD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIRHAoU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBA?=
 =?us-ascii?q?zEHrDJ/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8DIM2iB+CZ?=
 =?us-ascii?q?5pugTR2gSAOgTyBBAIJAhFrgRAIa4F5QAINZAsOcYFJY0yBewQCFEQOGBAlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sR?=
 =?us-ascii?q?AxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfNAGBDgGCdcM+NAeCK4FWgVkMn?=
 =?us-ascii?q?w0GEy+XCQ4GkiUuhzKQFyCnf4FpATOBXDMaJIM2TwMZD44gGR6Dbo9IPzQ9A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 klQqY4=
IronPort-Data: A9a23:SP0U6q0/BAOdvHv47vbD5cN1kn2cJEfYwER7XKvMYLTBsI5bpz1Rn
 GIYWW2BbvmCNGX9eYp+Pdi2oxsHuJCBx9I3GQA53Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0ilaYDkpOs/jY8E827Kyr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW3zH4bZsU00kBqIZvftXPFhe1
 KBGMi9YO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMvIMwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXLmYG9AjF+/RfD277/Vx204PjCoPvJNnQSpxSgVuyh
 1LNxjGsav0dHIXClWTcqyzEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mSsZfu+XUK0skWrv1kBe+dpA8xmthuSn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWM12FFyYS3Fnop4vQ9eKgBIdDFZNH5soR8tv4e6+txbYgfnFI47eJNZmOEZDhnW5
 1hmRgAMiqsei8QGzaq2+zgraBrw+caTJuLZziPQRH6lpiljbYSsYZDA1LQ2xfNHMZrfUVSL+
 nQJ8yR/0AzsJcHQ/MBuaL9UdF1M2xpjGGOF6bKIN8RwnwlBA1b5IehtDMhWfS+FyPosdz7ze
 1P0sghM/pJVN3bCRfYpM9vuVppwl/a4T4WNuhXogjxmPckZmOivo34GWKJs9zu9+KTRufxiZ
 szCKK5A815DWPw5nVJauNvxIZdym3xgnDqNLXwK503piPKfYmKYU7EILBOHYYgEAFCs8G3oH
 yJkH5LSkX13CbWgCgGOqNJ7BQ1UcRATWM6nw+QJLLLrClQ9QgkJVaSOqY7NjqQ+wsy5YM+To
 iriMqKZoXKj7UD6xfKiNyAzM+++DMsgxZ/5VAR1VWuVN7EYSd7HxM8im1EfJ9HLLcQzkqYmf
 OpPYMiaHPVERxLO/jlXP9G3r5VveF7vzUiCNjasKmp3NZNxZR37yvm9dCvW9Q4KEnWWs+k6q
 OaezQ/1e8cIaDljK8f0U8iR6W2Nk0ITot8vYHuQEOJvIB3t1KNINx3OiuQGJpBQCBfbmRqf+
 QWkITYZgujv+L0K0cT7qp2Fi6yLEOJOOFVQMEeGzLSxNAjcpnGCx60ZWsm2XDntbkHG04T8W
 vdw0NfHL+whoFZGl6FeAoRb5/syyPW3roAL0zk+OmvAamqaL49JI16E7JFpjbJMzLoIgjmGc
 BuD1fcCMIrYJf6/NkAaITckSeGx1fs0vD32xtZtKWXY4B5Hxpa2YX9wDTKt1hMEdKBUNbk7y
 9gPoMQVsgyzqiQ7O+a80xx7yT6+EWwiYY4G6LcqWJTmmyg6+GFkOJb8MBL70LuLStdLM3QpH
 AOqubr/t+xc63fGIlUOFinr/OtChJ4xlghA430cKn+oxNfUpP8F8ydA0DYwTwgP8BRj1th3G
 2l0Nn9aIbeF0CdoifNiAUGtOVBlLz+I9nPhz2AmkDXicHCpcWjWPkgRBP2o/n1Fw1lDfzNew
 q6U+FzlXRnuYsv1+Ck4AmxhlNDOUv1z8VfktP28PsHYAaQ/XyXpspWuaUUMtRHjJ8E732/Dh
 Oty+ddPeb/JDjERr4I7Grul++wpEj7cH1N7QNZl4K8tNkPfcmvr2TGxdmaASvkULPnOqUKFG
 8hiI/xUbCuH1QGMkGE/JbUNKLpKjvIW9II8Wrf0F1Un7ZqbjBRU6az1yAavpVUWU+1PkNk8I
 Lz/bzitMHKdrloKln7vrPtrAHuZY94FbjKtheyerb47KLMegs5RcGUZ8Li9j1OKOiRJojOWu
 wLiYffN7upAkI5DoarlIp9hNS6Vd+zhcfuu8R+hlvhzdvbNDJv+jBwUoVzZIAhmB7sddNBpn
 7CrstSs/kf6kJspcmLewb+tKrJo4JisYe9pLc7HFnlWsi+cUsvK4RFY2WSZK4RMoexN9PucW
 Aq0R8uhR+E7A+4H6iVuVBFfNBIBB4DcTKTq/3q9psvRLCkt61XMKdf/+EL5aW1eSDQzBKT/L
 Q3K6saevoUS6MwGARIfHPhpDqNpOFKpC+Nsa9T1siLeFWWyxE+Lvrz5jxc79DXXET++Hd3n5
 Y7eDA3LHPhoVHokEPkC22CzgvEWMJq5qew3Y15b5NN8zTy3ZILDwSLxLr1eYqy4UASrvH07W
 N0JRHQvA2PxUFyotD3itc/7UF736vMmY7/Ey/9Aw69QQzi7DsWMDdONM8umD2heIlPe8Q1sF
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:A1Ueu6lcjyggAa71RZGVVsvU3j3pDfI93DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Qr5OUtLpTnuAsW9qB/nlKKdgrN/AV7BZmTbUQKTRekI0WKI+V3d8kPFh41gPO
 tbHZRDNA==
X-Talos-CUID: =?us-ascii?q?9a23=3Ax2lG5WmX5/r129qmoYvEAip/bWLXOXr27jTSfEO?=
 =?us-ascii?q?qMkloD6C1dGaA2f86idU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmKH7vA1LIb+Xw/uwwd2S6kNE8TUj0vSpC3sDq8w?=
 =?us-ascii?q?85czeOnV3JCq3rQS8e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="53642866"
X-MGA-submission: =?us-ascii?q?MDGDbSep1f+kUlLYvNYGqMQLKd4F5lBDl+zihs?=
 =?us-ascii?q?4cRfmAp9ck39d6OdTLxnDCoKDFM63BmU6RWcG+4btZQmdEWxNPJEJVU9?=
 =?us-ascii?q?RdgCn6Hs+QWRwbJxxYF0ZOq1aO3SbA7O0vQPBLmEawfA4fjsvbvsYs1P?=
 =?us-ascii?q?W/g32W8DcdUux8gI4Vhtz1XA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681812269; i=markus.elfring@web.de;
	bh=RAlmL0+zlGIql4lZ1mGeYyjR5jABKB18T8namvvM6j4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Ux92INAufWOB5BclnrFcck7MTZ6oyj0E0R/HkluM03eKXvgp8/Vwo5AkGTQP0erc+
	 /a6LCLU65xxrxspzECB0CG7Soe6LboQeaukiqwNSoC3Fk4Lpe1gwEQ9b79klFYzfLb
	 uA4lIX6fyAplFcHEefaX1Lf0UFgeHKIFoAOqtRp5ld8iIka2BSmJIE09xWWiIbgFT/
	 f3cw7Adghoehn06fGNDiDWwzG5atqqvq/8RTb8F8YfpUgHyPLbAX9mBbneQdKGH3x5
	 SqWME7GHUf8+wDWwWBR8AoyN1W3BiK07OTbGFJvuPkPIyAX6xx5B6bN5LTIEwUuxL/
	 hFwwBmaCcnz8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MActo-1pdfZF1mpM-00BStk; Tue, 18
 Apr 2023 12:04:29 +0200
Message-ID: <9036ba34-8ef4-a3a7-0368-6fd3ed1248b3@web.de>
Date: Tue, 18 Apr 2023 12:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
 <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
In-Reply-To: <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdc/BTupVS9OOfPJBdwO+6X+pJLBZWXOF38yYv3UdsNJoeRmLbo
 mNr4OIE1VouzrjDGB3doa6Zym5RhyfTfvly/9vOhZutGS6ACEYMshPYPYXRw3JOxq5+D6pm
 U9L5VhY5BJF+YdOghjQAoR3TWZmcJ/UfWaEUzxaLBh/IUgyqwyGct9h3khZ4YDT7HK5Zlj0
 ekJW2abEGbi5FZz+cFbBA==
UI-OutboundReport: notjunk:1;M01:P0:Z/85V3rBuPI=;RZoaAEt9CZKwRUAb+IkQugOAuut
 RmRhWLkxwBm+6K7N/tiSVqppIUm9a3zUswBYd707X+vJputgstnnLeHwWiWAUpjiV2eGp0fd2
 Ner8hIMrbR8EqYx9EA1DrYUj34XRWbjUgmRbcPJGLzJazNH/nex+w7imy8ICRpBHoKLNoYxoc
 KvC+gVWLH3tfpyh82GJ1r+NEqy+6rpWC4e2e3uEtPaTcMq+PDrL4B4HmxTjFg37sTg8nG3F98
 Q+I2GTLhGxG/V3+QUOm5NQAZMz74o4bmqoTxwVzKuZT+OY3op1uNhqqCj80ZWjNtCPlpKTK5P
 582WDW6W06o0X2xPYFc0PXEYBmVkZWJZK8GPd83OR9XFNCVVJT4NAmsMAVt0GU70w+YW/0mR5
 znJgla9C4pKi+tUh3FN4eduuMT+jbxmOBaJb0031OY05JPWgPp41ycY47aNQK2ax9NhPWBm9Z
 Qt4h2Y9byNWQubrZkZkluKAzIqyifg1BavE6e6gMbDsckjWK54FCOI/oq5AskxH22xCeSPojH
 shl8TdAXPsc3QugTnXhs79RUTQT6E5DyhSvQe8PIYQag9G/ORoZ2WPFJIl9Se0SdgezOs4TdI
 Tih1JE8As+KGknl+cZ11YPlRfml++ZXALlOZ0rfrDm3/5q1/JVEtu1Xt7XmZqayb464Cf7Fm+
 VYZ1SXSLcY/gUffa9fhd/d999xdRlWhfCSfF45LHKQ0lSkjqHEqrKLv+ZRBkyhhFxt+a5jRmc
 ueO4oqFMM8zkqRXIgbDAZ6JQJHGyLmhLTwLb9JWQsQY/eccxXP8tIHo2VEh8G6/G2qnPSiEeF
 QMd9Dba96W/VSb9GScdZw5OgoTD/9BiRHbh4PYGbuEDoukS2EUj3WgPcjMECbDrvxzi1Uu5hT
 ipYFz1fHOm+Sy+QBt74wXLNW3rZ4k/g5zjfW3905J2/sUugTh2kQzDz2Z
Subject: [cocci] [PATCH v2 2/3] media: adv748x: Move a variable assignment
 behind condition checks in adv748x_hdmi_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1086
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/9036ba34-8ef4-a3a7-0368-6fd3ed1248b3%40web.de>

Date: Tue, 18 Apr 2023 09:30:25 +0200

Convert the explicit initialisation of the local variable =E2=80=9Cbt=E2=
=80=9D
at the beginning to an assignment statement directly before
the source code place where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
The change was rebased on source files from Linux next-20230417.

 drivers/media/i2c/adv748x/adv748x-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/=
adv748x/adv748x-hdmi.c
index b10263f4c0c0..14ff27aabe89 100644
=2D-- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -274,7 +274,7 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 {
 	struct adv748x_hdmi *hdmi =3D adv748x_sd_to_hdmi(sd);
 	struct adv748x_state *state =3D adv748x_hdmi_to_state(hdmi);
-	struct v4l2_bt_timings *bt =3D &timings->bt;
+	struct v4l2_bt_timings *bt;
 	int pixelclock;
 	int polarity;

@@ -298,7 +298,7 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 		return -ENODATA;

 	timings->type =3D V4L2_DV_BT_656_1120;
-
+	bt =3D &timings->bt;
 	bt->pixelclock =3D pixelclock;
 	bt->interlaced =3D hdmi_read(state, ADV748X_HDMI_F1H1) &
 				ADV748X_HDMI_F1H1_INTERLACED ?
=2D-
2.40.0

