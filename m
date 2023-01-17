Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FE8C3DA78
	for <cocci@archiver.kernel.org>; Tue, 17 Jan 2023 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VBnaNHOPnnkPibfVDNjufTGgsXqllOM4siqVvdm6P1c=;
  b=l1xIYp25h0TsAu57TcowR/8MnrMChMu7gqAr8MwBQwjyGcLq+Mu0aGhK
   QJQXveWwerH9pWOKVTUY1lHyLfaCkW6zSGerifZ5JCePWyUJtr77+Jp/0
   8ybDAi3B5dkgzdIXpVKCaBjTYVbEIwqP7rRKapitTubQqAdlnFXZ8Qeyr
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,222,1669071600"; 
   d="scan'208";a="88023130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2023 13:24:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D43C2E0387; Tue, 17 Jan 2023 13:24:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23525E016E
	for <cocci@sympa.inria.fr>; Tue, 17 Jan 2023 13:24:21 +0100 (CET)
IronPort-SDR: 63c69374_ozi1yaZDb1rcJjNGhVFH3dW85h3MTgrhamTO6fFVV4tTPXx
 QAnql8bhEjafNu1BronjCHIMaT6IiY/HldD3RaA==
X-IPAS-Result: =?us-ascii?q?A0GnBQBuksZjh07ASNlagQmBT4ItgQdWLgQLRYRPjnqCK?=
 =?us-ascii?q?IQrjliKToEsPg8BAwENOQgBAgQBAQMEhDpFAoUXAh0HAQQzBg4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEYCxcHDhAFIoVoDYI4KQERZ?=
 =?us-ascii?q?IEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAg06GDs9AQICASMdAQERJgEEC?=
 =?us-ascii?q?wsaAhEVAgJXBg0IAQGCegGCbQEDDiMHDKwRgTKBAYIIAQEGnAkfLCJTgV4DB?=
 =?us-ascii?q?oEULZAmeicQgVVEgTwMgnc+gmIFgRZHP4MZgmePb4pjCoE7fIEnDoFIgSklB?=
 =?us-ascii?q?A4DGSsdQAIBCzsyCkA1CQILSisaGweBCSooFQMEBAMCBhMDIgINKDEUBCkTD?=
 =?us-ascii?q?ScmaQkCAyJhBQMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDAiFOcAIuERMFA?=
 =?us-ascii?q?wsVKkcECDYFBhw2EgIIDxIPBiZDDkI3NBMGXAEpCw4RA1CBTgQvXn8KBikon?=
 =?us-ascii?q?DGDWYJ3wjk0B4IjgVCBUQyJfZR5BhMug2YBEoxfhiMOBpIbl0uNTJpAgXgkg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OOYNZM4osQDQ7AgcBCgEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpsn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:l3MOgqvc/HvQ0xAonAvFRBx57skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,222,1669071600"; 
   d="scan'208";a="88023116"
X-MGA-submission: =?us-ascii?q?MDFRW8M5z8suWZLh2S9NRa+mjXW7e3gIJrIQzU?=
 =?us-ascii?q?22AWXj8k4heCO+HB7C0uTsdzJ3XEO+tB6dRnI1/ntevdxU4jEKluLAI9?=
 =?us-ascii?q?TtskOeia1+Rr+qIz5+1WvN3nVbZqt/eYUFVTNpPooe0nH9L8Pea8Str7?=
 =?us-ascii?q?lgVuYsdt8h8pGGoDl2ogfBNg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:24:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673958259; bh=VBnaNHOPnnkPibfVDNjufTGgsXqllOM4siqVvdm6P1c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UCHEqmRWEZDwSk6DZ1ESIl9ZoQr9vFgLIG2WVkjWpMpKXReP+k9fLTgLC5PN9cLbK
	 t8KsEjdpaE5jZWGfvvxQr1UAxfRtxUv36fytxbQrr9jBowhbGRrQLK5Sr1cV24sQc3
	 ZzjVCKQMKpZPs3IyGTUURSiprFWI4Zuh6ODDhX17G0tKzHkV5/hmM6TLD6kr/01Ai4
	 wOT5+K6Xj98dkgvolPnjh53AsGt5aVTsrLNO2kvDyczkBDRF783/2/qASgzVwyQh44
	 HIPM/JTkgIWbGXQtjaBE8O/nmQ0mXy+w4zUgs/2KQHsqPIJpxJPUMHe2AUaY3mdrAC
	 f8H9tKmH5BbAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1pLJmI2jlF-005Uz7; Tue, 17
 Jan 2023 13:24:19 +0100
Message-ID: <584b115d-6812-bcf0-c1a6-6bc79b1cec4a@web.de>
Date: Tue, 17 Jan 2023 13:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <cd35c301-c1fc-80d2-c3b4-bf37a5dca522@web.de>
 <7bc15f4-154b-bfb5-4ab5-869f32af50ff@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7bc15f4-154b-bfb5-4ab5-869f32af50ff@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:az2REzwECY7qxvNcYJc08vZnumLRlvLtpWOMaJNdJ7BDUmuZmQt
 oqzU+lTlQs9pCfYFec9ZGebbM6Bfj6g6rs1ZaYYnLOFzCTZkfwU5DXyHQR7dDqutiQFP3oh
 MrtHI87pmukAM7GXi8X99Dr3jINv9aDkJc/aPXYIFZavNLqOLf/tOljMy5J8SE/xhW/js/v
 MhwxBYp3L8sCPjY175Amg==
UI-OutboundReport: notjunk:1;M01:P0:ybMvHnP7jAY=;J2LozmfbSNpW17HvufJxPX+VHOg
 W3kaAeln6qbfyl1FT5SR/KAoG8l/T255BRqk6fklkjW530OBJ40FbSbOvw/UR9osZEX2bscJz
 Am45k4WwudK8hC+qok1c1GSRz30LiWVvSBU+l3kQTUouQQuuq7MuGYBBFHNv6x/sAhFBFVKf4
 sbi4Fpc4MpYSYjizI2tGe+9josT6WAPIskvCD1bDGMDDCVETdQnBznxM89Y8m5k+8OLHxxxyl
 tSmcuQVLKouD6vUHVJ1j2wG02VlfWOAkQQdKxlGeWmvCjSHDtE5C1CEkRbr79U/svWCsg+Jz5
 5ioNzkMHoQ5GZELG29W+0k315L0GtW2CL8FpcN9hmWPhiOAOT476L5d+JrDmz4/eFjBByc0y6
 4wNYhB/QczDmM/7GN/gbu96JwVzk9oPZVfPFs541Sh1NMnnhXdvyLq/Z27srWCVE0F/g+aHbg
 BE/XRmFiqaUtihrtWdkFhKFsAI7OD0DgtaE8QxEoHKEU1RZ8/mBImZ8EaLmo21q1AG515wIjR
 iXmq3prRR5C7BVMXpmi1vWrQ4BxSFSSF7JTCdc+hPoaH+qiQhJMwgZORgXtgLXu/q+u0fGKrW
 MEeN20rMqhN1oPJb7AAft5q5aOZFGm2ej7gsnYGVMBNieuwaPaQ8hA+66AQmG1cr6a2hr8DoX
 8T+bbiHGLnyjz4FAggnx5HgK/umYej1L2xgSDGmdd+UupSEx88pLqojs7Q/go7XFUzCsuVRsv
 L047Shd1NxK26rHXAJwNXzuMNBp0/5Ra8BrQtbtr6f1f+fuoZ/jEM/AiPvRkzAiF/eJFeV7a6
 y1zE9VytouM+l1YInni448ihxSBaejA881k4YrdTgWCRQpbTRUidBbZziBdSQB83J8OUDZyuw
 1iiYAZu951CEto/EavYLitnch/drU9IG4h/F2wAHqHtod45yPTgQ4l2/pMKSFptmB+ULrqCrr
 D46Ggg==
Subject: Re: [cocci] Adding function attributes with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 815
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/584b115d-6812-bcf0-c1a6-6bc79b1cec4a%40web.de>

> Work on attributes is in progress.

Will an attribute like =E2=80=9C[[ nodiscard ( "Reminder: Please use the r=
eturn value
in meaningful ways." ) ]]=E2=80=9D be taken into account accordingly?
https://en.cppreference.com/w/c/language/attributes/nodiscard

Regards,
Markus
