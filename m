Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA51C76195
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H1MPxHXviBTm9+1/MMmwrhPapFh7IkMuatxpI0kIQSY=;
  b=oiCIOuZk6l1Fkd2xY8Zvv8Xoo8ZCJxi+UJihdPhF1BxuJ0R5XTZY3IrM
   TwDttm1stdDDw9QiwiKIYA5HSgYROAZXAFasH3g1G1tW6UjI6kvxZqoMg
   CyM5RfVm7eRAqfRwwNq3xPl01eU/Iw06JWRj56f/kaxCzXx1QBLuaEQKm
   s=;
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
X-IronPort-AV: E=Sophos;i="5.98,295,1673910000"; 
   d="scan'208";a="99378186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 19:26:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81CB1E0D55; Mon, 27 Mar 2023 19:26:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 73D32E0D40
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 19:26:37 +0200 (CEST)
IronPort-SDR: 6421d1cd_Q6mp/F8IfhhbT/JxMhGMh/Cp2tVn7Eg9Un9yhUn4jw9jQpq
 vygOpIQFk3vc80qxmQ2v/PGcdLLLWlxV90ZJ2RQ==
X-IPAS-Result: =?us-ascii?q?A0GIAABh0CFkhk7ASNlQChwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE+BAEBCwGCLYFLLwQLRoRTkQExhC+HLIc6hGeEAoMWPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSEfgKFOQIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGAkZBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6gigBAw4jB654g?=
 =?us-ascii?q?TKBAYIIAQEGnAofLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBPIMDPoQXhAWCZ44Si?=
 =?us-ascii?q?ykKgTR2gSAOgT2BBAIJAhFrgRIIZ4F8QAINYwsOb4FKAmRMgRElBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGjQRAggPEg8GJkQOQjc0E?=
 =?us-ascii?q?wZcASkLDhEDT4FHBC9bgQEGASYknUE8gR2UZZBHoCQ0B4IogVWBWQyfDAYTL?=
 =?us-ascii?q?oNqAZMdDgaSIy6HLZAPIKd6gXkkgVwzGiSDNk8DGQ+OIBmEDI9IPzQ7AgcLA?=
 =?us-ascii?q?QEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23:IZyBmh1Ze1X2pLvosmDO0w0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo68w1hSQBNyTwskHotSVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5Z3ebx9WiDe9f79+I
 wi6oRjMusILnYZsN6E9xwfGrXdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ
 7BAAzsoL2465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVzmu8
 7tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSWZEWMtaSi5PDZ6mb
 4YXDOQPM+lXoIfgqVUQsxa+CwmiC+HzxTFHnXL2wa833v49HQ3a0gEtHdQDu2nUotXvM6cSV
 Pi4wq7SwjXZbPNWxCz945XHfBAlr/GMR7NwcczeyUIyEA7LiU+fqZbmPzOIzeQBqWeV7+5uV
 eK1im4nrQ5xryOhx8gykYbFnJ8axU7d+Ch/3Y06KsG2RlRhbt64DJtfqTuaN41uT88+X2xlp
 jo2xqMHtJOnfCYHzJAqyhzBZ/KJcIWE/w7uWPqeLztmhHxoZLGyigq2/ES+1uDyVte43VdFo
 yRLjtTBsG0G2R/L6sWfVPdx40Ws1SyN2gzN8O1IPEQ5mbTBJ5MjwbM8jp4evEvZEiL4hUn6l
 qybe0Y+9uWr5enqZKjtqIWGOI9ukA7+N7wjmsyhDuQ8NQgDR22b+eOh1L3/50H4TqtFgeYsn
 qbErp/WPcUbpqinDA9Jyosv9QuzAjW83Nkag3ULNk9JdRaZg4TzOVzDI+j0DfKljFStlDdry
 erGPrrkApjVKXbMiq3hfbVg605H0gY9wtRf55xOCrEAJvLzVVT8tdLGARAiKQC73vjoBM171
 owFQW2PGLOWMLvOsV+U4eIiO/SAaJcPuDnhM/gl++LujXghlFABeqmmwYcYaHGjE/R9I0SZZ
 GLsjc0bHWcLuAo+Vu3qh0eYXT5dfXbhF547sxo7EoO9EYDbRsiHHryEwy6/EpBMLjRNCkqNC
 mvvb4XCUfABaCeNK8ttnyYsUbmnQY49kxqpsVm+g7lqNOzZ/mgavJTiyN9v/MXNmhwosz95F
 cKQ1yeKVW4w1m8STTNz0K1hiUh80UuYl6x5hfZZCZpY4PYNGgM7M4PMiuZ+DNvxchzOc83PS
 1u8RNiiRzYrQZZ54dIIeA5UC9+lg1iX1jqgBLI9lLGRApEwtK7fiTy5A89n0D7r0K0siVMrW
 MQHYWmvnLU5+gzXCojDnl+Wv6Krc64dwGjG82LViSK2vEBcURZoGZ/IXGsZa1Ge+cz550fDV
 6foE7kmKQ1M0+aGK61Aa8GvhlJDEqTNItPbNke4gWStHl6lwr2WbYzlMzE41T/eFVNCvgQd5
 3eAOiAhCy3nr2+IX28mLk7mf065qbo2k3i8VEJhiljSNyWJtpKw8x8R37mHTu8Lm6gDs2Eno
 il1G1C025TXDcCBrkxvZvYUessztXFA02+RrAlhJtq4Nak3o1cEcBls+W7q2Q92DIpojsUg6
 n8nn0JpMazN6FpabHuD2IzofLjeK2385heqPovfwFLDy5C7/qkV6fI3g0rutkelGxlq6G1ph
 v9S1XbU/ZDWFEwSXJb2B14w7AR/rqrGbzMV4oTJyTtzPKPyvjKqN8sBIuwjx17get5eNPnBD
 wruC4gAAMPoLuU2ml+vZxZCPeZI9adyMdn0P/2BkLWmOupthlfExSxO/Zx930SQ9iF9Vv+A3
 pALxOud1xeGUDG0hUmos8T+k4RJLT8IGW/3xS/hDY9XLqp8GORDQUKnOc6q3ZNTg5D3WnhX3
 EGuDRUK1Y7heBafaUD8wRwFzV4e8jSsnSq1ySAxkil89PPAmnOUhb2zLlxYaj0uJiEql1rnL
 ImqgspPWUGpa1Jsjx65/QPgwKMdoq1jLm7VSEMOfi7sLmgkXLHj09jKK8NJ9p4stj1aFeqmZ
 lXPAJv0uRgHyGXOG2VExTY0Xy6nsNP1klYp7QDVZGY2t3ffdcxqkF367cbfWOUX8z4IXih+h
 hHIC1L6M9TjrrD239/T9+u5UWymTJhadyLmmJiBuCWM7mpvGRSjnvq3l7ULCCAC2DTgn5lvX
 CTM9lPnZ5Xzkr69OqRhd1VpA1n174x7HJt/m80+nsNY1X8fj5STtX0J9AW7efBSw6HjdzwgQ
 TARwtjayBfo0gtvIzqFypn4WXOU3sZ6L4PjPSVJgGRkvpoMV/fc5acMhSZvp1uksQ/dBJo11
 iwQz/cj8j9Sgu0EvhYs0jTIB7kTGUdCOim/3x+M7t24sOBWfDP1KOf2ixA4xIH7Su7S8WQ+E
 D7jd5wvHDF99JB6OVPIijjo7538PcPXZpQVvwGVlBHJi65ULogwn7wEn3kCWyq1sHs7xuo8l
 REr04u9ud3NDmx3/7+iRDNcOCf0Ycw75Tzny6pT1JXzvcjnDtB6FzMHUYG9B9ehCjEPrrLKM
 wiUETszgmiWE/zTEEXMjSUu52KKGJetOXaNIXAfxtg3XxiRKntUhwUMVSk7lJo0RUi6gdbse
 0Bj6nUN90b1/1FSn/lwOUC1AQK97E+4Ly05Q5+FIF9K4xFesg3LZNeG4Ls7HjkErMf49krXc
 DPdPl4WSzhTCgveWjWBdvGv/YWSqbHCQLDkcL2XPPPW7rYDH/aQmcD1i9EgpWzTcJzQeCElV
 aJz21IfDyogRIKGwXNWGnZRzX6dKJTKwXX0sixv8pLvqrKyBl+pvNbeTeMVa4sn+gjq0/3aa
 KjP3mAjcWkejtRWmjfJ0ORNhgdNzX40MWD8S/Je6WmXEsey0udWF0JJO3k1bZUVqfhmj08UY
 paTi8uphO4iyKdrVhEfDgSnwJvhIMUOJyvV2ErvIkGNOfzGIDTKx5uyeqagUfhKi+4SsRSsu
 DGdGkulPzKZljCvWQr9eedLxDqWOhBTouTfOl5kFHTjQdT6axa6LM4/jDs4xqcxj2/LMmhUO
 CZ1ckdEpLmdpS1ChfA3F2tE53tjZe6K/kTRp/HfMYoTuOB3Dz5ckuVH/DIlxrET4CwFDP15l
 S3Or8J/9lGrlu7cr1gvGBFKqztNmMeKpRA4YPqfqcMGACeeuk1dvgDyQ1wQqtBoC8PiofVVw
 9nLzufoLStatsjT9o0aDtTVL8SONDwgNwDoEXjaFlhgL3bjOGfBikhaiPzX+GeSq81wj5H2m
 4cVDJJfWkY0EPwyFUlvWtAPasQSPHtsgfuAgcgE6GDr5gHWX9lft4vbW+i6BPLyNHCGgLMCa
 xZCktaaZcwDc4b83UJlcFxzmo/HTlHRUd56qSpkdgYooU9J/RCWr0U23F/5LByg6jkfGKzs9
 vbZohRza6Ih+WW1i7/SDkXHrm08nRtp8eg=
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:x7mgJ6+iH4I/3Kp6nKBuk+BAI+orL9Y04lQ7vn2ZKSY/TiSh/P
 re+MjztCWE6gr5PUtL9OxoV5PtfZqiz+8N3WB8B9iftWrdyQiVxeNZjLcKqgeIcxEWndQ86U
 4PScZD4PqaNykesS7AizPIdOrJ+bK8gcaVrNab9G11RQVmL4lr8gd+DW+gYzdLbTgDPoAhHJ
 6QovJaqyatPVQbB/7LekUtbqz5vcTCkJ+jWxIcGBI9gTP+8A9A4YSKaySw71MlSjtKzPMY/X
 LYlhGR3NTZj82G
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,295,1673910000"; 
   d="scan'208";a="99378151"
X-MGA-submission: =?us-ascii?q?MDHwT8WpPRQJHxh+lvawC1VdWhLEtbJN7HQ7Ug?=
 =?us-ascii?q?7cq4HfiB7RJ920ZGn9bPRDqHtgBvjH4u62z7Gtwyvqk4Cv5T3ghdji9i?=
 =?us-ascii?q?BjIRPkePkTcwnfKeOfEdCttDhRxrJfarDGrGC4/CTwn+q8KFmzgaUxk+?=
 =?us-ascii?q?dxkjON1ABBC707NDIHG90vEA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:26:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679937994; i=markus.elfring@web.de;
	bh=H1MPxHXviBTm9+1/MMmwrhPapFh7IkMuatxpI0kIQSY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D1xKs/Z40zBkefewF/nykMinZpA7ygIESgckwuzn5AK4tlfDn+la+P06oGGsgEh9P
	 xtnT5OAzmVBA1CsYuIpVWsU1vxyx0gwwf8QQ2KVkfPQCgA3oCjSksxKSEWT/Po0YLj
	 3RuWoJaOsmm8yjUYstXrJTryysQK8H+DfCasHdtfqfUFbDjVFkOtvhMAyAC++1YZFO
	 wPhH3Qid0JS7l7QUdNaFR4Rt60Y52nEHTgwIJNllRS9TirJgmFz5ndL71DyBHeGkZw
	 Nsm5Yq3XGhZO9mGdSaR2pKVpokCj4pAPmgshWmdTuyaf6MOtx88seGMNenKJm2GINL
	 ilovBjj4DH76w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMY1N-1pzl2j3D8x-00JXit; Mon, 27
 Mar 2023 19:26:34 +0200
Message-ID: <7a6c195f-42df-eef2-e2b7-9f7510dbdf06@web.de>
Date: Mon, 27 Mar 2023 19:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8d193937-532f-959f-9b84-d911984508aa@web.de>
 <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
 <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HvVD7nrmswxX08XbtKylMJjqi0QvPqsyuGw6/cRRS/7oMNVDGtv
 COamcrycoTnxMHCk9HIdloLK5aXXOIswv9ji2D+iIHZ2wfdijqZk/fYf81nJyIbaRL1WSLV
 HqX+uvFSBZ3xXOurC+BXiKxt0ivwwcLDQh3k6lGHuA70GV/iwt/7yZxYxrjpdWe/stFpFn5
 HvZAkevNMkFb29re19ZUQ==
UI-OutboundReport: notjunk:1;M01:P0:Z0N10fcH5kQ=;/QH3iZMNcue/NsFyq52k7t61FeF
 Gm8viHWFvZWgQInecibkNT1q7vLIUZdRGOvw+yFQkDH+Z4DAPBTqrWmD1s8IiS1UON/EtX1cV
 dkwl39VOdct1GZBCoVpUIwEV9OcXac4IJqwlXpH/cqu8gYZTcCEJxqnUT9y6wRu1Ovqq/OWu1
 Ai3bd3NEUznT1YdhdLJldGxzfVqC7x1iauLThYVL8+pdVIuCBqatcBM85a/kiOxpwPN9nZLIz
 KtsUr6/oPiR827EupAWZ7fLODEyvbUqN5oo1ZL7s8GnN+7HTr4buZX2B1mIUoOJO0V+uIJAxC
 bHTB+mReTI4pyj/Ru6RLIFEFT8JVkmhIR5HzSMxy20Zw/T7iJv3dEJdb+Q66UVV/8/DvAgRL9
 F2ryvAOCBV0A8NYq2bMsuQqK37af20kdpBFFYfyk/QthSwIWe4obbO8VCn0NRmqSN8htHNlMY
 IdQVdoxEtQmNEqB5eyV+6v6cYFjfGWIhYNweW/gY1d3blrcHAeQueaxnVI/vu24gJqU6qOAiS
 DrJrkwWUKx6mPIwgWlDEh50Oe+kfHOIsXDqE2j1UI8QS+Fry1HmbKilKO1cWCwMOrglkHcgdp
 ajVyGxh0GOMKcQLGJKfw6dbI/0hQTV/GBEne+F1uvnxm1P2UbuAs0w6kfBoz2QLb71UoWA30+
 glgK05PM9/rIkSJi+Y1zbUGRwJqusd0eCLWHhMidGkDG09SmzMAGSbiHmJnyUuWXnjtEBEV9y
 HgBQBcnZuEIMEPMABcXiD26FmXE/m2qSzf9KLt4UY6HAt7AIIHCmQKXPRwKzUxMZHAjhQfopf
 jJtA2xAGGOzBaEDyoP5+7IdIEE/1mt0pIrMRZ158n0/n5Pq5W644bucQ3BD0ih1rO34wdiJq6
 ELqpi9Rq8VgfuDj/eNM9H3upfLG1lngUkFqqy8OdW56nezpjfqbld5Ueu
Subject: Re: [cocci] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 965
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/7a6c195f-42df-eef2-e2b7-9f7510dbdf06%40web.de>

> Can you identify the issue with the current code and can you explain how
> your patch makes it better?

I propose to avoid a duplicate pointer check also in this function implementation.

Regards,
Markus

