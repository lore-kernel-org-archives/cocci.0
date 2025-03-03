Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E88C282C5
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gqKAvU34fJc3/7+256tAvca+dZqwxT9FoB+Y/pUL0JA=;
  b=C3XkLTwW03Igg3MqqodAfJz8V64uoeMwVUaA6jyFORERYEuM+w01v/Gy
   re8qRJaewGMdSK8af33WzpnjdlJJuw/BbpG5h7tpCPl9gUcRR8TpuCc0j
   3pjCazr27QFZbWQ7opUET79wOhzQuFwDtX0CV6AKkqGvm8IBF2i94SzmX
   U=;
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
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210878053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 13:48:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2850E0D1D; Mon,  3 Mar 2025 13:48:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 345D3E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 13:48:39 +0100 (CET)
IronPort-SDR: 67c5a526_hBjG8mhuhfzId1BXM5AqjmdA1L2Xavzsa/r2XkMrnsDUmqC
 iLPOqPDJ44ZEgGFj46jUVtBq8SG32N3bflXjtTw==
X-IPAS-Result: =?us-ascii?q?A0GTAQCOo8Vnfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuHU4RvhAaBVoF+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiBVIJ0AosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCA?=
 =?us-ascii?q?QMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHryR/M4EBggwBAQaCa?=
 =?us-ascii?q?ddzHywiV4FlCYEaLgGFa4JjAYYmhDwnD4FVRIEVJ4NBiB6CaYQaA4M9jRObR?=
 =?us-ascii?q?YFNHANZLAFVExcLBwWBOTgDIAo0FAQZAhQcAQ8GEARqeoJFaUk6Ag0CNYIeJ?=
 =?us-ascii?q?FiCK2oEBYNbhD2EQII/UYJCghFxgReIAoEthGodQAIBC209NwYDCxsGPaFuO?=
 =?us-ascii?q?oNPcgFSO0yCKpJvkDGicjQHgjiBZoFjDJ9eBhMvl0UOBpJ8AS6HZZBqIqkPg?=
 =?us-ascii?q?Wc6gVwzGiSDNk8DGQ+OITiDdY8KAbkeQjU8AgcBCgEBAwmFRgEBiiItBYFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:4nQHqRIed6gSyIY/ptmcuFlvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSZDN6Ko9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebgtWiDanfb9+M
 Bq6oAbVu8QYhYZpN7o8xAbOrnZUdOtawn9lK0iUkxjg+Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXjSi8
 rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTmZFR8pdSjBNDp+5Y
 4YJEuEPP/tXr5PlqlUNoxWxCgejCv7vxDFWmHL206813PguHwzdwAwgBsgDvGjIoNnrNqofV
 /2+wqnSzTXEavNbwTDz55LSchAivPGMRq97f8XVyUkhDQPFj1OQqYP4ND6S0eoCqXKb7+l9V
 eK0kWIppAVxoja1xsctjInJiZkYy17a+ipi2oo6OMO3RVd9bNW5H5ReqzuUOJFqQsM+XW5oo
 iA6x6UItJO4eCUH1JAqyRDfZfGDcYWF4A7uWumMLDp7mH5rdqyyihe8/0Wi1ODxWMe53EtOo
 yRLnNTBt24A2h/N58WZTPZ240Sv2S6X2gzN9+1IP1o4mbTFJ5Mj2LI8i5oevV7eEiL5gEn7i
 KCbel8q9+S18ejqZrvrqoWBO4JwjAz1L7ojmsiiAeQjLggBQXKb9/m91Lzi40L0WKlGg/srm
 afDqp/aP94UpquhDg9VzIkj7xG/Ai+j0NQfgHkHMEhJeRyZgIfyIV3BPe73Ae++g1Sqjjhr2
 +jLMqP8DpnTNHTPjqntcLRn50JByAc/181T6p1MBrEEOv3zW0vxtNLCDh8+Ngy52+HpB89n1
 oMdRGKPGbWVPqzWsV+G/OIvIu+MZIAOtTfzNfcq/OTigmInllMFe6mmxoMYaGqkEfR+P0WZf
 X3sj88cHWsSpAoxUPTqiEGeUT5Uf3u9Q6U86S0nB4KnForDXYCsgLmZ3CihBJFWZ2ZGCkqNE
 XjybYmEVe0MO2quJZpinyYCWLzkSYYn1A2prhTS1bVqNKzX9zceuJal08J6o6XfjxB3+TFqA
 sC112CWU3oykHkFSjM7x6NjplQ7zU2MleBTg+ZZDsBS7vUBcZk8NJGUm+d6EdHpRgPIeJGKT
 1ugQ9qOCDQ9CNk2xolKK2p0HdSvilj90ja2DqVdw7CCAp059orS0Wf1I4B2yyCCnIUokVgqC
 uJOL2mni+Yr/gnJA4/En22Wkq+rceIX2yubsC+mxGOUoExeGCp5V6bFWmoEegOCqN3w/F/PS
 fmqALIkMgxb0tKqLqpMd82vjFNaSfOlM9PbNSb5vm6gBBOFjomNdIPwdy1J2T/cEEEenygQ8
 GyAOAx4AT2u9SaWKj10EFX+K2/l6qEqrnKhS0gliQ2DdGVo0rbz8RkQ07jUcPIW2bQN8Bkst
 yl5Bh7pxNPTDNyJjwRvY6FYJ9g9thMP6WLesgVmdq6hKqVvnFsXdQI/61/81hByB59FmM4sh
 Gg31wc0Ja/Og31bcDbN+JnqOaDMYkT28gqubaGejnTXytWL4eEi7PoiqlPslB6kHAwu/iM0g
 JFuz3KA68CSX0IpWpXrXxNyrkAiz1m7Siw05oeOkGZpLbHxqDjJndQgGOoizB+kOdZZKqKNU
 gHoQIUBH8b7DusslhCyaw4cevhI/fsRNtmlauDA9aqlJudmkxq5gG4B7I0umlmU+X9EQ/XTl
 40A3+ne2wKGUznmi1L0l8ntmp1fIxwWEHC+zyfMG4NbIKF/Ls4QEWn7Bcqxy51lgoL1HX5V8
 Fn2H1QdxMqgYgafdXT42hBMk1saqzqrlENU1hRSlDck5uqa1S3KmaH5cQYff3RMTy9khEvtJ
 o69i5YbWlKpZk4njknt40Gy3KVdqKllSgubCU5VYyj7KX1jWaqsp/KDZcBI8pYhrSRQVqy1f
 1mbTrf3pxZS3TnkGiNSwzUydjfivZuc/VQyrWuHL2to6lfdd9txwxj3+9HWA/Jcn3IHSCR+l
 TjLFw2kJdD6td6QlprFrqW/Tzf7D8cVK3O0i9rd8nLntggISVWlkvu+m8PqC10/2C7/jZxxU
 DnQ6Qz7ac/t3ri7NuRueg9pAkX94ox0ANIb8MN4iZcO1HwdnpjQ82AAlDK5FNxB2r/lKlcJS
 yQKxdH9/wXvnkFuZCHspcqxRjCGz81tasPvKEYfwCEg9IZnDKmO7bpLtTR4qBy0oEiCBJo11
 idYwvwo5nkAhugPswd41SSRDIcZGkxANDDtnRCFhzynhJ1ef33nMb251U4k2MukEKnHuAZXH
 nDwZpYlGyZ0qMR5KlPFlnPpuMnof9zZbNRbsRPx8V+IquFPK48q0NcOizBmP23VonAvjeI2x
 RBjxpC1uoGbJn4lpvvjREQCaXusOoVKpnnklu5Gk9yT3pyzE5kEeH1DR5buQf+yUXoTufnhK
 weSAWg5o3afF6DYGFzX40NnonTTVpGzYivOfj9Dl4okHUTbfRAM5WJcFC83lZM4CA2wkcnoc
 UMjoysU+ka9sBxHjORhKxj4VG7b4gaucDY9DpaFf380pklP4VnYNcuG46d9BSZdq9eEpRaON
 3fdSgBGF2APVWSbClqlMrTktryiu6CIQ/GzKffDe+DEjOVEVOqTg7+r3JFn+TmkKciFeHVvR
 a5euAILTTVyHMLXnC8KQiocmnfWbsKVkxy7/zV+ssG19Pm4EBKq/4aEDKFedMl+4x3jy7nWL
 Pae3WwqTFQQnoNJ33LDz6ITmUIfmz07PSf4CqwO7GbEHqfXh7MREBMRLS9+fMIa6qUhwkxdN
 8nBldrv2vhng/RzB1ogNxSpk5OsYtEWZmu6KVXMCQCUOb7AKTCDypPyZr6gDLZLhvhQtFvps
 DCXSgnoOTHm9XGhXkKqNvxQySqANxtEoMfkexBhUC7oS9eufBS/NJUfYSQe57oyizuKMGcdN
 WI5aEZRtviK6igehPxjGmtH534jLO+emi/f4fOKYpAR+eBmBCh5jYc4qDwz1qdV4SdYRfd0h
 Dqar9hgpEujm/WOzTwvWQRHqzJCjoaG9Ut4PqCR+p5FUHfCtBUDiAfYQwwNvMdgA8bztrp4z
 9/SiOTsJT0E/9+VtcoQCs7IKd6WZXosNR26fVycRAABTDOtKSTenxkHyavUrCfK6MFn7MGwy
 /9sAvdBWVc4F+0XEBFgFd0GetJsWy881KSch4gO7Ga/qx/YQINbuIrGX7ScG6aKSn7RgL9aa
 h8P2b69I54UM9ix/kV4aURh2qnOFVDRW99lvSBrKAM56hYokjA2Xigo1kTpZxn4qmcUDuKxl
 wUqhxFWZOMw6HHz7l1xKleA905S2AEh3N7ihz6Wajv4Kqy9CJpXByTDvE80KprnQgxxYGVac
 mR7OT2CS78D1tOIkEh0hQWatZYdQZa0rIVBZwIMg+6abbMk3AYEwhg=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:PBXj066D1ibe6xFdyAPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:mHyvrmzypvTc8OteCiGFBgU1RcYkd1TUzU2IHHGZWTlqEbnMQkefrfY=
X-Talos-MUID: 9a23:Rr0SVAsCSX6NvmoI/c2ntCBIENdB5ZmXEl0Gmo0IsOCLEzdcAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210878022"
X-MGA-submission: =?us-ascii?q?MDH7S3vHkkJ0fBZh+4XXjMQfvxw+KwmcBu35vg?=
 =?us-ascii?q?hwOux6/lC/mRordvOtoNtNSiW0XvF3jZcfgv7LLWyu0+vIwx631SCWmt?=
 =?us-ascii?q?SUtQoD4aH9h8HLnDQfpZ0oFvC15YweWq+7/ofC0OseTN5J5excSUUluT?=
 =?us-ascii?q?4YMPO9+h3yw3ZUT0zwYtmlvw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:48:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741006105; x=1741610905; i=markus.elfring@web.de;
	bh=gqKAvU34fJc3/7+256tAvca+dZqwxT9FoB+Y/pUL0JA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qilV5SWcI/niSBpj5G75O5iTuDg/+Cb6KbdV2T0WQCshsFiqyiqkzRDE9gPKkSW1
	 6jOH7qZxOuoAGBBcp6Jn9JfvZ7dQmpYUczsO43MOXRva3c9WYIoKEeF0npdGBTYTA
	 9ep884/FmR82+HHgx1MLmVU9zBxzexzIAAUqN/51xCSxybbiAB+dCQMuVFO+BbA7c
	 16bdmYjCqnLvIqcyq1x02jzj2WWnEFeprQ5TvFhjo+RHw4Q7keyZgQba/KDvBeFli
	 RWRUKN6Xt21EX9vQrMB/AZMKYHpO0OXk5KpnwXeTZFZ5gmbsYjzFiwH35OESxp5qm
	 7Mrtbdt2rqr3JhVXiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1tG1aE02d9-00lOxD; Mon, 03
 Mar 2025 13:48:25 +0100
Message-ID: <6ce29de5-7b94-483e-973e-0c3834609281@web.de>
Date: Mon, 3 Mar 2025 13:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Nirmoy Das <nirmoy.das@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <a3329002-827e-d53b-8a4e-860342eb18f7@web.de>
Content-Language: en-GB
In-Reply-To: <a3329002-827e-d53b-8a4e-860342eb18f7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D38SucaZNBKs7tEQhlDqhSG7xYr9j5tje3qi3M1lHirwvz9lNK/
 EEaa206Azua6NNlfPGrZrEiGp4siO0BjKscbAtEyG2Hady6vziJAZ7ob0J9lqT6pMmJe6Te
 KsYjsHlNRoLULY+K3S85k1qsd9tWyzDM1iEsd3FgOeP4UAr7s1RLdhipjJ1IWeQLoL6QE7d
 tUDSD3PRGWFQ08mJXUOeQ==
UI-OutboundReport: notjunk:1;M01:P0:eVhm+A3HKkY=;fxGNwlYvbjWv7R7tyd29xzeVelY
 t//nfjhtpE/AURKbpEmGeGRBM+ezia+BS/KlGiuhTRgB3f6MqSg7qLTdOWAi7hplisfv0ATkU
 cGEGdvjDzYmpy7ZLrQlNDCIfpZ9eiOP5qT5BHbnG7YVsKA4gOOj3UIF4xNJZRpoB9yvyLP4rj
 15IvO9UjwCqnnCRtBAw8BhuuptiphgX86ByR277M2ZizjFabGCCbY39M7aZO+rQaSlw4MbsER
 27vJ9RcCMFTH8yZuTutuIMJCLxMJWC9uQFKbDhUZbre1QWst100ZcY7B1X7jDxEkUGeOh7Ba7
 EG0NsEDeaH0coNrnYrad54qo8RvJNTX9ET9vNWkE36QQX006W3k89CNYpg479EJO0OFHtmm4P
 o3TWINb1F5DcxAziX/K9OD8QSoZEmuY/brcinjxJ/l7QQwsleAVFDHVvU9eNfCK2zHsuwjY07
 LOHjgEOWrjqsrAldaYI8RrqN+ti9+uTO6+leW8TDlren4KttSAeHxXqJbBAtpuSSJv+TPpMzh
 /JqvcL+YzQUv56pUWSUAgiGBp64Y9oulq/Q0GquNl/1qA5ohyKsnas00M/dGWbWh7mOOvBwUd
 eHofm6uZiJPXZv2kqbf/3edzoP53TGodOjI0LtGU0A+eIhym6ebpRL1/OmyDfGsVXd/DQMl3P
 /Vs6m9afMLCB002iqWTT2EqdenHKb/DzrtZfVhe9WD7Z0Hs4Z1vTKUtTHx1ZKmu/jivOFxmrL
 8UfWA07NDbfdFW8voUiP5J7POoBcmUjpxaO8PabCe51n87JjcDWC3YkGV+VJBwkmZeUi2arGY
 gNsupFFoCLOpP5glv453kPx3i9onBH12QY6yRDPWEW5YHkrm9H+xkSl3eOE3Ic/RTtb1v8Ctp
 dCvndEjhaWA6yBDLFlYh0DjmEbnXn2xHJrSu1GArIeSjXmnw2SypWAvqIgvSL1SWOlSpZ9y6a
 ocHx18s2fIRb3g6vnG7kwlg0kcQFn4M9fzTbAgjdeQ8JagsgdnKgtG0fJBWSeCAplVWES+5JD
 ayNzLvavZHZtC8IusgX9PMYLBXM9yNBJJIxLTP7yBvgnRhxObIqcA3ESE216KwD7ze2ODprGl
 w1b6OaLvG8CfKWHEjNME/4cI7l7YbU90Zl8Op6nspYhnYVKS+/P7AV+y7Tohl0QVsEbzBpBh+
 LxBNK8F5iQ20o0WCNz/OCUwp89oDzsqSlrBLCWxHnY9JH6I6JlYTir+WZHJk2af7Pt154JZUM
 KBunt+7j482Ia26x80efTJpP6Ouzc+O/QlLPE00YVJCrL6LXVXKxdBWD6gxK1qKIXVD7Vwbuv
 N07rRm+vyAKDb2i+6VEfmU9YWYIftbtxw2GqOe92B5QnEMkmX7tVryr+cqP/KYqoNxnGMq42a
 Mnh3oA+mJpSasCf704f9zdBCjkqED+vyrk+h1sOQsqd2veBVbl5QokTh8O1/0p+83Gt0k/I6P
 25+970WbwPWrgsaUW3kOQXhWir4g=
Subject: [cocci] [PATCH RESEND] drm/mm: Adjust input parameter validation in
 DECLARE_NEXT_HOLE_ADDR()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2479
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/6ce29de5-7b94-483e-973e-0c3834609281%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Apr 2023 11:26:34 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the macro =E2=80=9CDECLARE_NEXT_HOLE_ADDR=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cnode=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 5fad79fd66ff ("drm/mm: cleanup and improve next_hole_*_addr()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_mm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 8257f9d4f619..95c316aa36e5 100644
=2D-- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -389,9 +389,13 @@ first_hole(struct drm_mm *mm,
 #define DECLARE_NEXT_HOLE_ADDR(name, first, last)			\
 static struct drm_mm_node *name(struct drm_mm_node *entry, u64 size)	\
 {									\
-	struct rb_node *parent, *node =3D &entry->rb_hole_addr;		\
+	struct rb_node *parent, *node;					\
 									\
-	if (!entry || RB_EMPTY_NODE(node))				\
+	if (!entry)							\
+		return NULL;						\
+									\
+	node =3D &entry->rb_hole_addr;					\
+	if (RB_EMPTY_NODE(node))					\
 		return NULL;						\
 									\
 	if (usable_hole_addr(node->first, size)) {			\
=2D-
2.40.0

