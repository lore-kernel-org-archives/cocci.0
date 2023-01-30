Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3715C54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 10:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a3ovSEFSlQD1GfZat0xTlMeyOJbLv6oIpVYO0S5+6uo=;
  b=BOrMx18t42ZHcJ+c56aDkNTcfqn8IQZITBiRLj4Y+wFCWEwV044G2Paz
   Pm/yPj+hiGLkz9o7eR2xUldy69B4Wr97hVxqqrTqkiXqJrQSibZt0uqEY
   2+KqU2wYs0O4QZKoBDCBV/i+dzTnoh5kfc+mypMMqGQ9jxWLuWI8GUikd
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90035078"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 11:07:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5058E7446; Mon, 30 Jan 2023 11:07:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2A4DE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 11:07:08 +0100 (CET)
IronPort-SDR: 63d796cd_UKLNtBH9V6LCOR7N2ssz540bi43bJN17VvTFD64ZGsr30hw
 dpylHc1APlAul/s9NMCPwJeis/EXXPwz7XkdyGQ==
X-IPAS-Result: =?us-ascii?q?A0GjJADllddjhwsR49RaGwEBAQE8AQEBAwMBAQECAQEBB?=
 =?us-ascii?q?QEBARWBTwKCK4EIVi4EC0WET456gXcxhCuOWYo5gUA+DwEDAQ0UAQEnBAECB?=
 =?us-ascii?q?AEBAwMBOoRGAoUlAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR1M9AQICASMdAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVwYNCAEBgnoBgm0BAw4jBwypP4EygQGCCAEBBoFAARVBmXIfLCJTgV4DB?=
 =?us-ascii?q?oEULAGQK3onEIFVRIE8gwM+gmIBAgGBXoNYgmeQY4J+iAwKgTl3gSUOgUaBD?=
 =?us-ascii?q?wIJAhF0QCUEDgMZKx1AAgELOzIKPzUJAgtKEBsaGweBBiooFQMEBAMCBhMDI?=
 =?us-ascii?q?gINKDEUBCkTDScmaQkCAyJfBQMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDA?=
 =?us-ascii?q?h9PcAIuERMFAwsVKkcECDYFBhs2EgIIDxIPBiZDDkI3NBMGXAEpCw4RA1CBT?=
 =?us-ascii?q?gQvXoEEBikmnR2DAFcClT2vfjQHgiaBUoFSDIl+lHkGEy6DZhOTBg4GkhyXT?=
 =?us-ascii?q?4JNiwOaQ4FkATeBXDMaJIM2TwMZD445hAyBC5ERQDQCAQgwAgcBCgEBAwmFR?=
 =?us-ascii?q?wEBhloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:3sVMAa9L6ueRTvKOnp/jDrUDmXqTJUtcMsCJ2f8bNWPcYEJGY0x3z
 WMdXWHVbvqJY2ajLtl3bIu3pEtU78PTmtJiHlBt+X1EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPylYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f4nW8rWo4ow/jb8kg35a+q4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE7cc1NnAsOpYkytkpKF5J8
 KA7K2hRYUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhV/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUJ8ArO+PJqvgA/yiQq37u3MvTZdOCGYthLxka5q
 zjUxzXmV0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZvfPBCeJunmfgi4jBfNvFOhmywLVlqWBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7uz9pZW1qe38kN+iBcQGBTJaOXReEWPp9/G88Nhj1HojW/46SPbdszHjJd3n6
 xynxMTUr5AUi9IC3aym5zgraBrx+MSQFmbZCi3tXm+k6AdwYoLgX4Kh7Uqz0BqtBIOeU0XHo
 3UO3cSThAzvMX1vvH3UKAnuNOj4jxpgDNE6qQM/d3XG32r0k0NPhagKvFlDyL5Ba67ogwPBb
 k7Joh9275ROJnasZqIfS9vvVJlylPe4ToW9DqC8gj9yjn5ZK1HvEMZGOh/44owRuBN8+U3CE
 crGLZnxVB7294w9lGTnH4/xLoPHNghnmD+NHMmlp/hW+ePQPTaUT6sIKl2Dcqgw48u5TPb9o
 75i2z+x40wHCoXWO3GJmaZKdAxiBSVlWfje9pIGHsbdelcOMD97V5f5n+h7E6Q7xPs9qws91
 irgMqOu4AGl1CWvxMTjQiwLVY4Dqr4k9CJmYnB1bAr5s5XhCK72hJoim1IMVeFP3IReITRcF
 ZHpou3QXawdeSeN4DkHc5j2oaprcRnh10rEPDOobHJ7N9RsThDAsI2sNAb+1jg8Pgzuv+sHo
 pqkylz6R7gHTF9cF8r4Uq+k4G6wmnk/o9hMeXX0DONdQ2jS1bR7CjfQi6Y3Kv4cKB+YyTq90
 R2XMCgipuLMgtEU9YDXiZC9sovzLepaG3BePmjE7ISZMTvR0XqjzLRhDseJX2H5f0Hl9JqyY
 d56y6nHD8QGu1JRoa9QIq1O34tnw/fO/ph0lh9FGlfPZHSVUoJQGGGMh5Rzh/cc141nthuTc
 WPR3NtjYJGiGt7vSXwVLyobNtWz7+kewGTu3K5kMXfBxXFF+ZScWh9vJDiKsitWKYV1PK4Dw
 esMvM036RS1uiE1M+Sp3zxlyGCREkMuC6kXlIkWIIvOuDoZzltvZZ/9CCiv7qqfNPRKEE0he
 QGPiIT42r9z+0vlclgIL0br49Zzv5o1lSpx/AcwHGjRwtvhrd0r7SJV6gUyH1h0zA0Y8uddO
 VpLFkxSJIfVzQhJmfpsYmGIMCNCDS2/5Ube5QYolmrYbk/wTU3LDjQ3Ftis9XAj0VB3X2Zk7
 pSH7l36QBDWfM3V9Qkja35P8vDMY4R4yVzfpZqBAc+AIagfXRPkpa2fPUwztBrtBJIKtn3t/
 OVF0r55VvzmCHQ2vaY+Noi90IYQQjCiIEhpY6lo3IENLFHmVACC4xq8AGHvRZoVPN3Py1GyN
 OJ2LMEWVxie6jeHngpGOYEyeY1LjNwbz/tcXIOzPmMXkaqtnhwwurLqyyXOrmsKQdJvrMUDF
 r3sZw+ySlK3u38FtFLO/e9lO3W5a+YqfAfT/v6428RXGoMhsNNDS1AT0Ly1sy+rMS9ixRa1v
 RzCVYDS3edN2YRhpKqyM6RhViGfC8L/a/SMyy+36+9xVNLoNdzcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZyVS80X6QsR9cyJVL4QqIpeuHgrTTSXCHinlqGvaCkjhY6ry3CDn6fCsvh/
 JbZXV7EeQ+vvL3ThsRs22CoUsb70F4m6QXxQq4cxzKyozW9EXJAMukXd5kLYn2Rfuoey7mgD
 AwhrkN7Yck+YdiAWQrx6pLvU29zw8QQb8zhKGVBE1y8Mk+L6UDpPFel3jht6TF6d1MPCQ1hx
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:h4UA264ww/41g+j4xwPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90035055"
X-MGA-submission: =?us-ascii?q?MDEuFqHPF0I9cv0B7zuEAb39UqAaEjRqgF1jdS?=
 =?us-ascii?q?SjDZ/u8Deu8FeSz+s5oRKtNPq4HE5gVOxYWnROu3xc0RqOpBB1DVI8t7?=
 =?us-ascii?q?0xzhfRBQEIc81RzPnVU08Yw4ulcrUG8lJjRKpjiP4g4CJJkiUdKT1kEc?=
 =?us-ascii?q?qXac3ejOCbGRf8hL+8Yudn9w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:07:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1675073227; bh=a3ovSEFSlQD1GfZat0xTlMeyOJbLv6oIpVYO0S5+6uo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fm4MPP5b4L6jgEtxuA8nyYH3k7TbBOctPLMCp8zIHfdA+KkyHRDHiFAHOt87fWm21
	 pjEzNYIDG0SO0xi9gp1qlDTzb8A/XztayUabhqw0xTjhIhrZJwcaDPddTPH83HnAb/
	 1lMrYDnocZmWU7kLp5L8GYnvalMGf3JZomf7j95cDbQxK009L9DQHHmr+vZV4WqvPU
	 KD1Cx5T9nlKQShoLq3SfILFha5rW+ITbW0RAfaCrHt3xNQFyYxvxllNx2DbN8KRBr9
	 rhMFSuWrJ1xhE4nLEd8I0cIFMyGIx8/cx/bWNFDrRgSzjLPlBNLBy3x0J6NA7u9TXn
	 MstYYDj74n3Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1pQIh702wU-00Dlzu; Mon, 30
 Jan 2023 11:07:07 +0100
Message-ID: <4af5fe15-c163-bf27-bdbe-d5b2f2120a94@web.de>
Date: Mon, 30 Jan 2023 11:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Luca Coelho <luca@coelho.fi>
Cc: cocci@inria.fr
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
 <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
 <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
 <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdFHl4beHlW6262887AIE69ZgQF+qEikv4Q5KQdP168M5O3N/r9
 uWHv3yqZC4AfXJ7fdBgux0nR0pjTvXlDmLmJ1aLXOFIDwQiL4ungQR8wuKpKpGUik8SRO2c
 KVeXSrznmC6/aSf9Yz4ytYUSLaw7OmUN1P/0ms0T87Z/docH9scSopfdeVDtNcJ3OLrs5nh
 ll5iJVK8oUBM1mqBrvpfQ==
UI-OutboundReport: notjunk:1;M01:P0:gEy35tKRVUg=;C1gPmTqSctBxZy5mae4UXUrBhbL
 mSYcjAadJIQKSJlxzwhSU5qWq4GoZ7JrpJU/pOiI1rnyuY423IZB27NBna/VBu+O+oiw92O+M
 +vlo+mPQKpaEi1Ll6hiIPJwV+OxAflVujCwCv1RRf9bsx7eqUnzUv4Y1mtUJzmsIWIU2pA7i5
 Xa3WdaqvB39XPU4Oix9T1BJJiS5QeypsrBdz3aAzQQwOSE5h9S5iyzV0e/7Rmxrd5U/k5oU5w
 mbySWmrvsj/vzQk7E6b8Lijpp/kMYaoyvXECCjbAYi5mXj4yviTQde9ZqCiVvP/qEo/YFWvq/
 z8mimPYKWOPkejqbL1LGGPDfOAvUkCqIUDKi+IBA9ZZIzlbdu3cobUUmtgnuAaEzzK+JteKnw
 y4N+3vxFD8RxEjqQsRU5S/p0CUc0JmNnbFztoqfk06U0YufcwwrBxb1Ew4v+k6KFmVYQqyW72
 IVelMIuXH8XB7XbeSY1Tk9KLMK/aJwoIFXZ1CCUfGz4W9HLxTGpr7EBcbln6b9tlZPqMFws8R
 QSogxzQwWmlRgPTkLiIGMklmrltrHW1+9aClHDDRXHK2erX9lbfUkfWhBu1UwDFTUR8lsPvC7
 /Svo71za4y3SMdZWvGeNVvAfmPZWt9tvenjjBsCQsbeIG2U/bGfLqCWLwPZ447/5FNXf70ynX
 mdVHS5uumy1Iz0qGNrK+oXVUJFU1mgBg15TXYHFBMB5t2WXcQGbverjFwy3N+QdFy5P2xAqyn
 /DTHVT4NsrKanITQOM4DpMi5lS1HN3gADVFgfu9eciLmZcxwkqUpWOClcNGDRrLDkSqbzl9YX
 WXh5Omf6C/Q880+nhoy5R7uAYPFukSQOrHZEJsBTxix0S1pbf96nT1UU1sx8Fnw7WhQjJtfpH
 eW/pW5c9Qa1v+HvKCQd7i5boY5UWRifc+xwGLZ39zXclHRiSu/Xv8eV4f9J2p7spMwgpOidvI
 bUqP0Q==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 852
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/4af5fe15-c163-bf27-bdbe-d5b2f2120a94%40web.de>

>> Would update candidates be found by using the SmPL asterisk
>> functionality?
> Sorry, I don't think I'm aware of this functionality.


I imagine that you can become interested in the term =E2=80=9Csemantic mat=
ch=E2=80=9D
for further use cases.

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b9603af4eca7f4c771d57=
a3861855332e9bb1c4c/docs/manual/cocci_syntax.tex#L1208
https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar005.html

Regards,
Markus

