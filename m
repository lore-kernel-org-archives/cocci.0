Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3075FC87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t02NKWJOClHgWj3cfiIrdjz4LOAvkfsvvxJlCK+0iXY=;
  b=jzTDrdUzcmkS0ovTmcdEkSymB60W7ZR2OArZwYH6WSs7L5J0tTuHqbyN
   c4nGiidqZ2W7o51bnQLgllXs9Sf8Ge6T67xGq3NqfjIL29k33M+n7NDpq
   Y6EykG65qrppR67foiPfL+rArOPe3YIVdyXhJ4THdI9nATGSAPRNdtn0g
   Q=;
X-CSE-ConnectionGUID: WEB22fOOQ7m/h9Zo8zjHLw==
X-CSE-MsgGUID: V5zdlpB+SwCzqUArIwFyDg==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233965494"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 18:18:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5565AE0C55; Sat,  2 Aug 2025 18:18:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BA1F8E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 18:18:51 +0200 (CEST)
X-CSE-ConnectionGUID: 9oof/P0fSS+lVa7qAeTVJg==
X-CSE-MsgGUID: RQb/uhl/SHCbF8NeMtyOsA==
IronPort-SDR: 688e3a60_i20u9oOmaXDQtCXwj2/hHLsIIagVg0nyw+uRHsfyA9P+kB3
 QvSS28wOeHw5gwtYlEqYx/8ojN/ZWCIXE/srb6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EMBwDXOY5ogA4P49RODB4BAQsSDECBSAuCRIEGVDMEC?=
 =?us-ascii?q?0mEGTyPUIIkhDuHPIdViHmDUgIPAQMBDU4BAgQBAQMEhHwCAgKMGgIeBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECAQwRBh0BAREmAQQLCQIaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giIBBhABAw4kB5QJnEaBMoEBggwBAQbaXh8sIlmBZAmBG?=
 =?us-ascii?q?y6FbYJkAYYng0J6Jw+BVUSBPAuCRzE+hAEBQYNbgmmCJoEWg2ONBIhwUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1gXlBGT+DUx4Gb?=
 =?us-ascii?q?Q8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIU2mDqvbDQHgjiBZ?=
 =?us-ascii?q?4FkDJ9sBhADL5dSDgaTBZkGIqkfgX4kgVwzGiSDNk8DGQ+OIYQzvTRBNTwCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGLW4FLAQE?=
IronPort-PHdr: A9a23:vkEwdB/vyH9nfP9uWZy2ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 wqHvr401ACRB83y0LFttan/i+jYQ2sO4JKM4jgpUadncFsor/tTtCEbRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiTSzbL9oM
 Bm7owrdutQKjYZgNqo91AbCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuxbbQwSA/3cRTGoYnAdQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86
 apgVQLlhz0GNz4992HXl9BwgadGqx+vuxBz34jZa5yOOfFgYq3SY88VRWtZXsZQSSNBBJ+8b
 5ASBOYFJOpUspXxq0cLoRa4GAKiBv7gyiVQi3H106M13OouHxzY0gE+EdIAsHbbo8n6OqoJT
 eC11bPFwSnfY/9I2zrw7pXDfBA7ofGLWLJ9ac3fxlM1FwPGk1WQspHuMTyR1uQDqWib7uxgV
 e2ygGMgrA9+uCKvxsQxionSnI4bxVTE9StjwIY0I924R1V2YNC6H5RLrS2VKpV5T9okTmp1t
 yk01qcItoSnfCgW1psn3RjfZuSHfoWK/h/vSfqcLCtmiXxqd7+yhBa//0e9xuPzVse4zFhEo
 zREn9TRuH0A1QDf5MaIR/Z8/Eqs2jeC2xzX5+xFJ00/iKnVK4Y5z7Iui5Yfr17PEjHolEj0l
 qOaa0Up9vK15+noernropCRO5V6hw3jKKgjmNCzDf4lPgUIQmOV4/6z1Kf58k38WLhKjuM5k
 q3esJ3CIMQbobO5AxNP3oct9RmwFC2q38kGknUfLVJFfgyIj5TxNl3QPfz0E+2zj0qynDpp3
 fzKI73sDo/QInXMiLvheKxy609YyAo919Bf4JdUB6kGLv3pQE/xt8HYDgQjPwK7x+bnBs991
 oIYWWKAGaKYPr3dvkSS6u0yPeaAfJUVtyrlK/g5+/7uimc0mVsHcqinx5QXbHS4E+9nIkWYZ
 Hrjmc0BHn0Qsgo/SuzqklyCXiRJa3a8RaIw/is7B56+DYffWoCth6SM0zu8HpJKem9GC0uBE
 WzodoWBQ/cDcjieIs5nkjweVLiuUZUt1R+0tAPizbpoNfLb+jcEupL7yNh1++rTmAks+TBsA
 MSSzWaNQWJukG4QSTE407hzoVZjxVed0qZ2meRVFdlU5/NUTgc2L5DdwPJhBNzoRw3OYM+FR
 0ulQtWnBDE8Vso/zdAAbEhjB9uvkhbN0zK3DL8QjbOLHoA7/7rE0XboP8hzxG7K1LI5j1koW
 sZBL3GriLNi+QTLHI7Ji0uZmL6qdasC2C7N83+Ow3KXsk9AXwAjGZnCCFICYkrf5fDw+UrGS
 /f6C6kjMwIHzcedI69OQtzvl1RPAvn5bpCWaGW6kGaYBBCSx7rKYpC5VX8a2XD4AVIHjhtb0
 HKILwk4CW/1hmvEDyF1U3/rbVnt9+ZWt36xCEM5mVLZJ3Z93qa4r0ZGzceXTOkei/dd4H9JQ
 1RcGV+824iTEN+cv097e64aZ9oh4VBB3GaftgpnP5XmIboxzkUGfVFRuEXjnw5yFp0GidIj+
 VYj1glvMuS11F1bdjWX9Y/9MPvbJzq65wihPpbfwUqWy9OK4uEK4fU8pU/kuVSMH1Ah7m4h/
 t1byXqa6b3VAQBUXZ+iGl0v+U1coLfXKjI4+5uS1XBoNvystSTe3tsyGOY/4hOnYssZL66OU
 gP/eyEDL+6pLuFi212gbxZeeftX6LZxJcStMf2PxK+sOu9k2jOgl2VOpo5ngAqK8GJnR+jE0
 oxgobnQ1xabVzr6kFaqs9zm0YFCazYIG2OjyC/iTIdPb6x2dIwPBC+gOcqyjtl5gpfsXTZf+
 jvBTxsj0dWqZAHUQljzxwxW2mwIrHbhlSb5hz14njc1r7aOiTTUyreqfx4GN2hXAWh62A21e
 87u1Y9cBRXuNlR68XntrVz3zKVauqllemzaQEMSOjPzM3knSKy78LyLf89I7pos9yRRSuW1J
 16AGduf61MX1T3uG2xGyXU1bTav79/clgZ5lXnbAXJ9tnvfdulvyB2Z6NGWFpszlnIWATJ1j
 zXaHA32GtCz/siP0brHvPq/UW2JSZBZNyXmh9Dl1mPz9ShhBhuxmOq2k9vsHF0h0CP14NJtU
 D3BsBf2ZoSDO72SCet8ZQEoAVb975A/AYRiis4qg5pW33EGh5KT9H5BkGHpMNwd17isJHYKQ
 DcKxZbS7m2HkAVGJ2iK2pm/e3GT2MpnaPGlb2lQ1i91481RCaiS5aBJhmMv+wD+91iOJ6Eg2
 G5BgfI1oGYXmeQIpBYgwkD/SvgJEE9UMDat3xWE4tairblGMWOmcLy+zk17zpiqCLCPpB0ZW
 W6sIM54W3UqsYMmbRSVjC6WiMmsYtTbYNMNuwfBlh7Bi7IQM5ctjr8QgiEhP2vhvHojwup9j
 Bp03Jj8spLUTgcltK+/HBNcMSX4Is0J/TS4x4NXhMWLxMaCGpt7GzMEdITlR7SkHXhB0Javf
 xbLCzA6pnqBTPD6FBWc9VwggnbBCZGtOFmIKXNfwdgoF3z/bARPxQsTWjs9hJswEAunkdfgf
 ElO7TcU/lfkqxFIx7EgJ1zlX2zYvgvtdiYsRc3VMk9N9g8brRSwU4TW/qdpEipf5JHksAGdN
 jnReVFTFW9QEkXWAlf+Iv+x6NOG/+XQD7i7KObSJKWArvZBXu2Eg42i2M1q8lPufo2GbHxlE
 uF+0E1eW3t0XdvUkXMDRmQexSfKctLerwy25yl06Jm29viyHgno4O7tQ/NbY9Bo5gzziryIM
 PSIwn9wLzoBkJgLwDfewbwbljb+kglIcD+gWfQFvC/JFufLn7NPSgQcYGV1PddJ6KQ12k9MP
 9Tag5X7zOwwiPl9EFpDWVH7/6PhLcUXP2GwMk/GD0eXJfyHIzPM2cT+faK7T/VZkuxVsxS6v
 TvTHVXkO3yPkDzgVhbnNu8p7mnTJBtFpIS0aQpgE0DmS8/6LAK2Opl7gHx+wLE5gG/LKX9JM
 TV4dBAozPXY5idZj/NjXm1ZuyA8d6/ewXnftrSec8pF1JkjSj55nO9b/nkgnr5c7SUeAedwh
 DOXtNll5VevjuiIzDNjFhtIsDdCwoyR7iAAce3U8IdNXXHc8VcD92KVXl4vrsFmF8aplqRe0
 NnJm4rsJT0E/9+erq5+T4DEbdmKNnYsK0+jADnPEA4MViKmL0nagFFB1u6f/DuZo9Jpz/qk0
 IpLQbhdWlsvE/ocAUkwB90OLqB8WTY8mKKahsoFjZJRhAbcToNWs8KePhpzKfDoNSrfkrROI
 RcFk+uQxWE7KYDxnUBvOAESoQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HGvCJazifMFqXZlJsVsOKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3ANuPRUGjKXnL7C1r0BcSDE+5qZjJuI3rawjDoe0G?=
 =?us-ascii?q?DMiVtdrTKUHadxJ1GnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATue4/g5nQNcPoakx5RLXN7R9xoxS2q7pFUAJ1q4?=
 =?us-ascii?q?mkMOqZQp9HiuMqy+eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233965474"
X-MGA-submission: =?us-ascii?q?MDF985AzWt+qJ99Cc2yf+BLOzX9rof9Gh6N7/o?=
 =?us-ascii?q?2ZtwIbrHvm3skevbyCVgzFqdCkKWpptDhdyS733uUXAHf78LLEcRKaKK?=
 =?us-ascii?q?sNfbE/ZJOlZMkkREEV3M81yhFTG+Eck7aJX3sMIkgG/CaQmq7lucHlxs?=
 =?us-ascii?q?MZ0NdLIAg1bzhNGbmlnkClaQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 18:18:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754151519; x=1754756319; i=markus.elfring@web.de;
	bh=t02NKWJOClHgWj3cfiIrdjz4LOAvkfsvvxJlCK+0iXY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h/xE3PLkPRCnSVJhiZ7SnRJIiREwWjUmmT5WgBYICQ5rI21SseVbSlogeBUg1DYH
	 bDL4wTN403nz5IN0+y8x2j7zMb83aZCmIqCmyXZvti5+c1Fsx5ABZZEATBN6ufVpD
	 f/lT2sJ/4UIIThVbeIn6f5gurNEeuDKuBEjdz05uHOFMqxNFX9EJltDj03yZoFpaw
	 d84XihdRTh8t5NA+pES5oz7gVS/54pwE78bvuFCp1BwolP3jyWw2DKZjqJu1oeDs+
	 qRksnq+AfGSm4t9PZUHulxZR1ZE+SNT19OUxtT2E6++4H81a/jWBgTxEVTD1hJthZ
	 5e5abXl2+EQxqxKCpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1v8wsJ3sht-00PGxP; Sat, 02
 Aug 2025 18:18:38 +0200
Message-ID: <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
Date: Sat, 2 Aug 2025 18:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGRMgV9FThA0hTdpzfwbqSLScL7/gMVpy8J7IPNgJv9yPxXuRgo
 obd2ds/6ktVKsPKo0bBDN7nNtY5N/2E7lLEduMsf83bpkKQ5AJpRh1w6ILJuccuaCJWzPGj
 xnOiKOKUnlFCqAK6gycx1ZRjsJBWHB3DkV23ZSsSbCS3vaDutNKfSi+4Kke/YwY4wdVhCdT
 wDmqMM5PABGrSaLZ655iQ==
UI-OutboundReport: notjunk:1;M01:P0:4TGMzetXFxg=;Oz33sPOBNPr9Ot33ADXu+5QtoXG
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2941
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/51664351-746c-4d7a-ae45-2a610ba45176%40web.de>

>>>      The one in the if is matching with the call closest to it,
>>
>> I interpret this hit as a false positive.
>> (The first lock call in the if branch is not the relevant companion cal=
l
>> from the function implementation.)
>>
>>
>>>                                                                 not th=
e
>>> call at the beginning of the function.
>>
>> This is an essential requirement for the discussed source code search p=
attern,
>> isn't it?
>=20
> No.

I hope still that a better common understanding can be achieved.


>      I don't understand why you think that.

The source code search pattern tries to find a pair of lock calls.
Is the passed expression determined for the metavariable =E2=80=9Cy=E2=80=
=9D after the second
lock call was found at the beginning of the function implementation?

May these two calls be kept close together also in the desired search resu=
lt?

Regards,
Markus
