Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB3AC433F5
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:27:15 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24871286"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:27:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A4CDE00D3; Mon,  7 Mar 2022 21:27:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23682E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:27:10 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: qWMJSa4Gf9KageCmFwJgY9ThTKKDoM8Xr/Nju5jD1z/6ETqWyN26rDvteyr8CdhNqt2HFXaAns
 UwpNWG90LSWDRyOsLjT3GpArfaHNwukuxcWd0yeBPXyIEzIINDG+OtR40QdYub734+qkf/AjMH
 D0b3F+of8B4wiwc7Jxh0uc9oh6cKGMKrOXkjIPGYSdxxsKIj3KCcXIw8F5zNsobr8s8//OkWSF
 LYZmo96r1wDwKGzLgbRIVhZxLjpOCb2Pqfp5Kc29LWgcbcHTzypclZBQTpxLlrqlMpwWm9uPKW
 e72a4PaeXqw4UtSLJ/UTljZr
X-IPAS-Result: =?us-ascii?q?A0AYAgBSaiZigAMP49RaHQEBAQEJARIBBQUBQIFagihpF?=
 =?us-ascii?q?VcrBAtEhFSOc4F3MZI5hEWFYoF7CwEDAQ0SAQElBQECBAEBghKCdQKEHgIdB?=
 =?us-ascii?q?wEERwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQ0NCQUICgcOD?=
 =?us-ascii?q?gc2Bl4GZASBSwSBdAs0DYI1IoNsAQICASMVCAEBESYBBAsLDgwCJgICTAsGD?=
 =?us-ascii?q?QgBAYMAAYJkAQMNJQutdIExgQGCCAEBBoE/AYMIHywiUoFbAwaBECyKE4M7e?=
 =?us-ascii?q?icQgVVEgTwMgnc+gmMBAQKBXoMagmWWLYFBwmQ0B4ISgTqBQAuJP5RMBhQug?=
 =?us-ascii?q?2GSVw4GkV4thSWRA40TmWY1gVYBgWozGiSDOE4BAgECDQECAgMBAgECCQEBA?=
 =?us-ascii?q?o4dg3IziixANAstAgYBCgEBAwkBgVaDcAEBjCYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ZViXtKAvASkqChVW/1Hlw5YqxClBgxIJ4kV8jS/XYbTApGgg3jMGy
 TAYUGuEafyDMWKnKNlxPtvj/RwFsZeDnNBqOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPhXFvW0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoymQlsF09
 c5Iia65W0Q2Hf3Lof0fbDANRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 pT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN58HcCcGv+auLe02h9rrZ5LIPCFe
 PMfMwYwLwvhSgdRHXU+XcdWcOCA3ySjLWQB9jp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwm
 47d12H+Hw1cK9GVjzaImp6xugPRtT/iUZMXKaa9ysxjkh6M5TwUMQQUanLu9JFVlXWCc95YL
 kUV/A8noq4z6FGnQ7HBYvGonJKXlkNEB4EKT4XW/CnSmvOEuW51E0BZFmYpVTAwiCMhbRAHv
 rNjt/buAyBmurSIUxpxHZ/J82/rYUD5wUc4ZSIFSw8M5dWmmI86igCnczqOOKuyk8GzBjz6h
 TyHxMTfu1nxpZ5Uv0lY1QmZ695JmnQvZlNljukwdjz/hj6VnKb/O+SVBaHztJ6s1rqxQFibp
 2QjkMOD9u0IBpzlvHXTHLtQTej1v67eb2a0bbtT838JqGrFF5mLLdg43d2CDBw2Wir5UWK1M
 RSM52u9GrcJZyvxPMebnL5d++xzkPS+TI27PhwlRoMAO9BwchOK5idjeQaZ0AjQfLsEwckC1
 WOgWZ/0Vx4yUPw5pBLvHrt1+eJ1mkgWmD2CLbimnkzP+efPPxa9FOZVWHPQNbpRxP3f8G3oH
 yN3bZviJ+N3C7KvPUE6MOc7cTg3EJTMLcuu+pwPK7XaeVIO9aNII6a5/I7NsrdNx8x9/tokN
 FnkMqOB4Fag13DBNyuQbXVvNOHmUZpl8yAkMCZqMVvxgyovZoOm7aE+cZorfOB7pbI5kqMuF
 6EIK5eaH/BCajXb4DBDP5Pzm4xVckj5jwy5OSf4MiM0eIRtRlCS99K9Jlnv+SACAzCZr8w7p
 7H8hArXTYBdFRtvBoDaZav3nV+2uHEcnsN0XlfJe4UCJh+zrdIycyGo1605OcABLxnH1wC27
 QfODEdKv/TJrq807MLN2/KOobCpJO0iTEBUKG/WsOStPi7A82v/moJNXbrafT3ZU2+oqqyua
 f8MlqP5N+Ab2klHucxwHu8zn6454tLuoZ5czxhlRSmaMQ70V+k4enTWj9NSsqBtx6NCvVXkU
 Ey4+u5cZeeDNvTjHQNDPwEidOmCiaoZl2WA9/gzO0mmtiZ78KDeCBdXOASQzjNQJv15Pdp9k
 +smvccX7S25iwYra4rX0HoLqj7UdnFQAb86spw6AZPwjlR5wF91YavaVn387qaJZogeKUItO
 DKV2PHPirk0KpAuqJbv+aUhHNaxhKjifDhPy0IeYUuEkJzJi5fbGfGXHSsfFmxoItdvioqf+
 VSH82VqKK/I8zoAaA1rQTW3Aw8YbPGG0hWZ9rbK/VE1i2G3W2aLIGBV1SNhOqwG2zo0QwW3N
 410BIoovfgGsS0xMuYPtZZZlsHe
IronPort-HdrOrdr: A9a23:2oYLAaAweOWkRzblHemI55DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3OD1KbcdKMLsytHSuQ4y9QYWcelSAZsQkjuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24871285"
X-MGA-submission: =?us-ascii?q?MDGD552MGxMhentu6jqgTUDsfkFTJfdbLYTMgo?=
 =?us-ascii?q?YYSipKvOYJdJAHhkr0M66YpSOXRe+d/u25Lc7+0EHEkqrrcL1jisGNah?=
 =?us-ascii?q?+75oHONK7PEdrMmSJ9TGdlZkuLgercUebfr3uHcjcgPSv9cSgmkgbwJw?=
 =?us-ascii?q?Rd1QPvGhpaaHTYtlAGZFtTxw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:27:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646684828;
	bh=i58RtDI2GyjEMQj4jcT9Bb0YL8Taw3+aE1DZMBsx3lU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YXbpDPKLRdkAEDRe9wHfpCDGMR1A6DWeuEvCU7jruq/JQ1vgNeBR5xONicwIKdJP5
	 9wUJklbsA2V2yWrAs0h749zAyMHyuRgfb6Pq/Tovtjzzpe62C7DhJyrWalMpRz9V93
	 vEYHqECsWfduf4B9uQNGcey0aFrwuNTwPttlVaZ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.71.136]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1nTmuz2TuL-002GyN; Mon, 07
 Mar 2022 21:27:08 +0100
Message-ID: <52d3cc40-8526-d031-6b5e-703dc7015ac9@web.de>
Date: Mon, 7 Mar 2022 21:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
 <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BCr0FCKUpcea3GOwJv0oZ2e4lD+a0dZDgumGjPzgmuzYc82bdhT
 62RbqLpJLVUJ6YYFy8eOcDByqP6xBTDfiw43+KRKI8ZlwC3lpExV9zp4WYv71X7wJWZNfNr
 trbSUSIHj4OF5VRSbJ4VPChhri3WkOBvW9U3XSGakCFCat7pV4hPzbZ3GC+t+zCkoIfNDeB
 j7fRLykZZyT60vToiaZLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mufgmBrW4ws=:xlLLf1lUarfwA9WdQmx7YF
 pyn5F9Gxr25cx3n5k64xWY8VXwF4CTft7cpZ2SzY8afh3hQaEPavdki63Ei/LS0lrWVSJ5/IJ
 IVUlk2DcpLLGvelwksi0vkpa2tqy87jMFrJb3Mqu81a1J56tT3Qba7aakNbGFgQNGbHFkzT04
 NBgqr6szXZ58QYQ2UVIoN7V1fCbyN6PCqWlBPKMFYjR3aHZD/r9Lx4tFQmDRhoIfavH+CIEWj
 E9Yt74tmPuaQTk/FvjYirqLhAj3+W7N83CPts9RVDZsTs2FpHZNpsD1bigUsTmkMVtWTs7kf+
 nFBEqAPzTjTjfG1uvGgT6YupY73Xk6VQ8l1cfHZ2411Av8T/cFTADwl87a6hSpYldCBTBzHgW
 hpvzZOb7okmcRHFU2v6RikDBMaKmMzTcvHZgSrfsfwqMDWTDY/pPgfx9n9h7KzRJhBfIKR21p
 e0pHfZ1jQqlUnaksOyiUSFyKo0o5ZH2wJhXIo7RlZMdBmacfKxgIHEplpxYEgm5ohaZ95QXBC
 DmkZ1DDA4KLG49HQE1EmDYstN9bspEfmZv8m21i7h2cOguE2wMu+TewteH83YZhI36kNrVGPs
 lZi1uD1o9zO5a0wCAFkNK5HVjMRFsV5CjJHATVqPOnxgPjcDIOoHxHudeJMBq4cINdGanarDw
 ooy+6AOiXu+yg2wFDXrBFeIMll2VpruC/0zK2SVhF4jiZr1K3ECtHkEk3qGfK2TqkaRFSkH0p
 3Btffd+F2a8QfdWUKNVosluOMZBn839WFLcqt+dBN0e9J+uwNNSi+wBjQ01ZRd45JEc06vtc0
 wE1+gQ1esruco1FbHVrHKJzFh66Xq2pTMJAtOs+lc016T3DcQwwOHJ5mhwB2s9cxw5prMNKl4
 6ullqMQ+XO6mHlJDjKUc1YenCwiFhgnmN8gkX39aMdD7snY/Y94b2IhamINkiWw0jHvQfGQJR
 IDEeWGQTMWoKmt8m5EDyK0i3sKU5bFJHL4+aBfZ6e0eijOjeJrgxVzPxcEWebvch4YOlDoGKF
 gL27ICf65cwW1fBocev2zCR/hfW0XN5Aj/IjEuymJagpveleutzQoWYjj4DKs7e9ojfWx6Sa8
 y/8FgS6IHZR7As=
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 178
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/52d3cc40-8526-d031-6b5e-703dc7015ac9%40web.de>


> Is E2=3D=3D0 enforced somehow?


I guess =E2=80=92 not yet.


Will any more extensions become relevant for the Coccinelle software
so that the semantic patch (or isomorphism) language would be safer for
the shown use case?



> What is rule27?


I suggest to take another look at a representation for the development
history.

https://github.com/coccinelle/coccinelle/blame/57cbff0c5768e22bb2d8c20e8da=
e74294515c6b3/standard.iso#L560


Thus I imagine that other software developers could tell a bit more about
corresponding background information.

Regards,
Markus

