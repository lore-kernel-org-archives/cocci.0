Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BFC41535
	for <cocci@archiver.kernel.org>; Tue, 19 Dec 2023 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a2+BEHVtouGppwfHcjABHJZu9IjFUB9dRIrPyCoyxc8=;
  b=aFesM3J81/oIXwCh6s5Ffl0vN1M1mU1B9t3gX3y4+PC1ycSihHddkmZV
   lWGmnpKNAFSiXG23Ens0I+/9pEccFXMv00EH/36UcNk79Q4a8g7uM8bXp
   eOmEkc0nG3tWfuYMUIiI4MigOWyU/iT6EhEqNu6bUoRSGZPN17hi9SavQ
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143156527"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2023 16:34:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08DF8E0CCE; Tue, 19 Dec 2023 16:34:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9BB1CE004E
	for <cocci@sympa.inria.fr>; Tue, 19 Dec 2023 16:34:22 +0100 (CET)
IronPort-SDR: 6581b7fd_XPOIsLOjG/+w0v2f0K6SQDfvXPMrA3LS9y3CGsPm24d9WG2
 8LJSoSFQRluHo4ehwgE/Kf5LCPuTXMLLVwBVTzA==
X-IPAS-Result: =?us-ascii?q?A0FXAwBst4Flh07ASNlagQmBT4I5gVIwBAtIhFOPQYF1M?=
 =?us-ascii?q?IQ7hzWHTIRrhASBVoFAPg8BAwENQQECBAEBAwQ4hEcChzQCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNglwBE?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjHQEBESYBDx8BBQImAgJXB?=
 =?us-ascii?q?gESAgEBgnyCKwEDMQeuH4EygQGCCQEBBoJmrHIfLCJWgWAJgRouiBsBhWaDQ?=
 =?us-ascii?q?HonD4FVRIE8g0GECoQUgmiDZoU3BzKCHINQkgd9BUFwGwMHA38PKwcEMCIGC?=
 =?us-ascii?q?RQtIwZQBCghCRMSQIFggVIKfj8PDhGCPiICPTYZSIJaFQw0BEZ1ECoEFBeBD?=
 =?us-ascii?q?m4bEh43ERAXDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNH?=
 =?us-ascii?q?AIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPDBsCGx4NJyMCLEIDE?=
 =?us-ascii?q?QUQAhYDJBYENBEJCygDLAY4AhMMBgYJXiYHDwkEJwMIBAMrKQMjdhEDBAoDF?=
 =?us-ascii?q?AcLB0gfBgMDAwIhAwsJCAMZKx1AAgELbT01BgMLGwY+AqYSfIEOgnbEeDQHg?=
 =?us-ascii?q?jSBYIFhDJ8qBhMvlyQOBpJRLodQkE0gqD2BYzqBXDMaJIM2TwMZD445hBKPR?=
 =?us-ascii?q?0A1OwIHCwEBAwmFRgEBgyY0gUEBAQ?=
IronPort-PHdr: A9a23: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
 RcFk+uQxWU7M4rmxwp9Z1M8kImYQyLt
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:AmIiEaEuLoGRXI7QpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:zB5wIGDVrYdm7+36EyRF0R4IKIclSH360lf8M2iHFXoxcpTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ArfI4Ag22t9bpmGtC5Q5j/dCfGDUj/L/zJx0pyJM?=
 =?us-ascii?q?84pOPFSB7MgnNoQSdTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="74870574"
X-MGA-submission: =?us-ascii?q?MDHR7vjjVdZPEjMGMQSLGziHB7f5DgohunBOnI?=
 =?us-ascii?q?xWN0HGnysJXITwiHGY2k77KiwN+B/0TyS/OZ7NIr9ot5brIT62/sk5Vx?=
 =?us-ascii?q?DrUTscyA2vPpBixMg7nqalOgjUMgo6CtItFqYWC42Il2KxFmgXye9B+c?=
 =?us-ascii?q?hZ1rFGy6hxE79SWxB7iGmlsg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:34:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703000060; x=1703604860; i=markus.elfring@web.de;
	bh=ELfN4U9np08GBF/FMF+QrtAqU4uT40C8danVIjILAro=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=FUxZRvxdMuBuhlzmr5rEjD/QatuH5CmRYXgzE4kl4eUDV19e+ZSdVPEkN4BgrOuh
	 o5XqVb0a5I5etaOapS4abysPcVp6MEU7y9JD9GicZ+YDy1rYPmEq6KernqwG8DO6m
	 fCBrq05Hqlqb8RvQDRA0g8y8ZoMGVpDsLMHDXKVKpZKWpP5Xz51qM45OB6LqbkCzt
	 ou2GyELuGYZimHXK9Z17iADo3vXKJBO8mDdbyWgPnVSkUodp9hdfy5FCGgCGUNgrS
	 05fKRB61ideP+ZllykjIsXoEY3fNKQoxfPU+dnA0u4cePHzKvp12flZhiQEUP+bbg
	 5CG0ZGfsCV4Z6emdEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1rhPgq3VKh-00STCY; Tue, 19
 Dec 2023 16:34:19 +0100
Message-ID: <f007f92c-a355-4bb9-a715-aa42ee6c647b@web.de>
Date: Tue, 19 Dec 2023 16:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjhsMO2bB8+nD7c7+p6s/ulFW7kzBQgTwWHDT3htCK5RkSp7UH0
 eKIPW1jgIOUi/ZkvNRDAy2Y5QJJ5sHTpvk30jaJetwdy2oPIFsCUuCCazWWDM7L0RJB82wd
 ZFGktXCo2j8qBNnYrNIuTQ+ybpRoMe+wPDyPIGK55TDnSWv/uQ/IlA535TKPY6cQaii67t5
 KroN6Q4bfgxT8T2Cmh5kQ==
UI-OutboundReport: notjunk:1;M01:P0:c0vGM0T+RLM=;QUrm6gfIeOpEppBOYa1XzxAUvRX
 DnvYrxxf4vfGCtT65Gf94NEOw5LUa6ErGNCgOLv37N5pnBELWH+i72uaBcaVUdXMW3pxw4ql7
 mr+QO/1jmlu8BUB2Fl+i++PHOvXxriqrgZDXxtDmQo0q5vpcA8prIaSVegEvMQbrYTDxjkI6J
 HvQN9HGsoOBkk6kwJmS/Rv62h0Qex4il15/uW0Dl67pjl/BWPUDOilK+gffYRcDdTm2LKxseB
 OtA/pmlro9IQV9+eNrlBHQRd4vdoZyETZ+t6c8TEUTWiOvRE4PeahZr7r4u4izG/msNaek/cI
 GkhEVNHYG0mllOpqAcZX+a4iRAUjvIvHAXPPapySBgEP+MFTxOiGPb1ugIbMvRWDzU4MPteDn
 znp2tLkvOmngWA59U5a0NuSRxoHQHK75Ro1qaxmdGF2h/PORMdbeAv1x0x0h0LeH66wAnB+ML
 B7vOsMsRS6Qu6WLWVog4sqacxBy02dJT+wWExMmiKkMh68SruOLfGvAYoNx1ULJ0KJyw06Zfc
 diQ8Bn+UYaKmuAEbf9hBa+UySw4sUIY3V9DE+sxlKdty7bkrWpRWGKVNx2VCs1UbXOABbGziK
 CtK+K36Df5XJ7DEFuLSEgRLPbIRI3BwmpZBGgmfvRzCDEc3n+Xs9WFz8pXGUTW5R5B4N84Qz1
 U3/UZwxj1AAEegNyD/RCCk9tqWag6Zdt76ZHesHERETimhrRDvgJWjw7lUkbk4Q9o40Q5k6OT
 d/eF4dU3x6F0WvmzFi9G6pXOJnQo/m7bplifzCM0e/oV0ovf7QI9khO7emwRWel/wKLaydgJq
 KHRyCIkmB6Mfi6238iRv1uaWEDEtizXnFmO3wn0r24E2Wj4StlXJ2qy2nhBIj0N2dQTGtLXPF
 eYQqOfasnzOuTkPUCntCzWqANed0eHpM5Jt9VND5wlsPlgr+mpmW75RhJ5dEQTut0o06oIMey
 MRj2LQ==
Subject: [cocci] [PATCH 2/3] kobject: Improve a size determination in
 kobject_uevent_env()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1350
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/f007f92c-a355-4bb9-a715-aa42ee6c647b%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:00:22 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 811e579ed89d..a9b1bc02f65c 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -521,7 +521,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 	}

 	/* environment buffer */
-	env =3D kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
+	env =3D kzalloc(sizeof(*env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;

=2D-
2.43.0

