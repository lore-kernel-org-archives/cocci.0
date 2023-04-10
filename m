Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B949C76196
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jvs8/SF+N9QJIvlU31YFb+KIXF2B/hNHAeFn9Dtoh2s=;
  b=pf8xT3bsnnXk2M9QmYyffmQAIuQY7FsXcfMMZW4QWggnupii/hsxTRKV
   YJIyzbOSjnujexnCf11QHJSQAsrMnSivAvYRl+tHOSM3sNz6DshRPbFLI
   hJA33VL6hZqfUiFKQlrkVqIg4PgUK4n9ghk9cxj74h0LkpStmSp+K6cqC
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102253138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 09:33:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2F339E7313; Mon, 10 Apr 2023 09:33:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6938FE72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 09:33:51 +0200 (CEST)
IronPort-SDR: 6433bbde_mhyEUZpS2PtagySbOe8Yu0XAmHZNdoR5MIRStGz4y6h9V24
 tjgcwyKbZQMK5BUkFXcr9HvOWNZNPhE3PwlU5Cw==
X-IPAS-Result: =?us-ascii?q?A0E/AACyQzNkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItdVYvBAtGhFORMIQwjmyIa4FWgUA+DwEDAQ09BAECBAEBAwSEf?=
 =?us-ascii?q?wKFPQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?g06PgECAgEjBBkBAREnDwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHDKtsfzOBA?=
 =?us-ascii?q?YIIAQEGgUABmkofLCJUgV4DBoEULQGNCYQuAicPgVVEgTwMgkcwPoJiBYFdg?=
 =?us-ascii?q?1uCZ45mi0WBNHSBIA6BPYEEAgkCEWuBEAhrgXlAAg1kCw5vgUljTIF7BAIUL?=
 =?us-ascii?q?SUEDgMZKx1AAgELdT81BgMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPB?=
 =?us-ascii?q?iZEDkI3MxMGgQYLDhEDUIFGBC9ZgQEGS5wPgV2CLIFFGQGTaLA5NAeCKoFWg?=
 =?us-ascii?q?VkMig2VAAYTL5cJDgaSJZdzII0zmkyBaQEzgUgNBzMaJIM2TwMZD44gGR6DO?=
 =?us-ascii?q?zOPSD80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:8/C7gaq6BH0cI3Q+j7pAX17TrdJeBmIqYRIvgKrLsJaIsI4StFCzt
 garIBmPaPjcNDHyfohyPoW1pk0PvpaBxoJgSVRppXphFikX8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGj9SuvLrRC9H5qyo42tE5wRmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2l1ZbUZ+qUnCl12z
 tIaGhwMfh7Ah9uPlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5vwJkXdRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfNvuTKOl1Uqj9ABNvLEefiQau8Mx33E/
 ESb7mChXhhEG9+2nG/tHnWE37KTw3qiBur+DoaQ/flhi1y73X0WEBRQVF2hoPD/hFTWc9ZWN
 EUQ/gI8rK047kXtT9/nXhT+rmTsg/IHc99XDvF89wyHjKbZi+qEOoQaZn0ZUN0m9589eQQR+
 F27s9L5C39viYTAHBpx6YyohT+1PCEUK0oLaikFURYJ7rHfTGcb0UqnojFLT/bdszHlJd3j6
 2zb9HBl3N3/meZbi//koTgrlhr1/sChc+Ij2unAdk6Ihu+TTK2sfYiz80Xb4J6sx67GEADa4
 xDod+C05ewDC9SyiTaRXOgIFryz6J643ND0hFlyA98++j7r93PLkWFsDNNWdR0B3iUsI2eBj
 KrvVeV5uc470JyCMP4fXm5JI552pZUM7Py8PhwuUvJAY4JqaCiM9zx0aEib0gjFyRZ8yPlhZ
 M/BLJj0VB727JiLKhLpGI/xNpd0mUgDKZ/7HsCTI+mPjOfBPyfMIVv7GALeNrtkhE97nOkl2
 48Ca5XTkks3vBzWO2eOuY8VMV0QK3UnTZn5w/G7hcbTSjeK7FoJUqeLqZt4I9INt/0Myo/go
 y/hMmcFlguXrSOfdG2iNCo/AJuxBswXhSxgYkQR0aOAgCVLjXCHt/1OL/PavNAPqIRe8BKDZ
 6NfJprZXqQWF26vFvZ0RcCVkbGOvS+D3WqmVxdJqhBmF3K5b1yWoo3XbUH0+TMQDyG6k8I7r
 vfynknYWJcPDUAqRsrfdPvlnRv7sGk/idBCeRLCAuBSX0Hwr6lsCSj61cEsL+82dB7s+zq91
 iStOyk+m9XjmYEPzYT2tfi2lLvxS+paNWhGLlbf9oezZHX7/HL84IpuU9SoXDH6VUGvypqDe
 Nd68vDYG98ElWZsrIBTPetKz6U/xt23vJ5c7F1uM0vqZmSRKIFLAye5z+xQkJZS15lluQeSc
 WCeyOlwYLmmFpvsLw8MGVADcO+G68AxphDTyvYEeGPB+y59+eu8Y3V4ZhWjpnRUE+poDdkD3
 +wkhc8x7j6/gDoMNvKtrHhd10aIH0w6f5QXjLMoK661tVNz0XBHW4LWNQHu6pLWa9lsDFgjE
 gXJuIX83YZj1mjwWFttM0iVxudMp4U8iDYTxn84Glm5sN7khPg24R5vzQoKXjlllhVq7uYiF
 VVoZmtUJLqP9QhGnMJsfX6hMCAfCQy7+n7e8UoolmrYQxOWV0jIFmkcOPmMzm8d4WlzbjhWx
 5DG6WfHABLBXtD94Ts2YmFh88fcdN1W8hbQveyaBOGHIsUKWiXkiaqQemY4kRvrLscvjknhp
 +Mx3uJPRYDkFCwX+YsXNpK70OkOdRW6O2Bye/Ft06cXF2X6ejvp+zyvKVi0S/xdNc7x7k60J
 Mx/FP1hDy3k+n61kQkaIqoQL5tfvv0jvoMCc4y2A182ieKUqz4xva/A8iT7unQQfOxvtsQDe
 6fxbDOJF1KCiUREw1HtqNZ2AUvmQN0mSjCl4sWL3rQoLa8TiMBtbkA47ZWstVq3LgZM3kyZr
 SHDVYDs3s1gzoVmoNq1Ho4eXDeLCM7Be9mJ1CuRsN1+S8zFHumTlgESq3jhZx93O5lIUftJt
 L29ivzF92Kbg6QTTEbYhIukO5RSwMePANpsLcP8KUdFkRu4WMPD5wUJ/0a6I8drlOxxy9aGR
 QziTueNbv8QBslgwUNKZxhkExoyD7r9aoHir3ifq9WOEh0s7hzVHui49HPGbXBpSQFQAsfQU
 jTLgveJ4sxUiK9uBxVeXvFvPMJeEW/ZAKAjc4X8iCmcAmyWmWi9g7rFlyRx2QGTXzPAWIz/7
 IneTxfzSAWqteuahJtFuoh1pVsMAGw7neA0eVkH9sVrjyyhSlQLNvkZLY5MH6Q8fvYeD30kT
 GqlgKoe5STBsfBsdBLh/JL8Uw3ZCuFm1hIV4NA21xv8Vst0LNro7HhdGuNI/Hp8PDfupA1iA
 c9L4WX+Z3Bd3bkwLdv+JZWHbSNP2f7QgH4Fkaw4fwoeHD5GaYg3OLdd8MahmMAJ/wwhVKkGG
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:b9J7OKvYtdmhfeJlZgExEZ6j7skDqNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102253137"
X-MGA-submission: =?us-ascii?q?MDEsQTPImWLh44mFNr2dmzZkuF4/5B0JRsVOxV?=
 =?us-ascii?q?vPnluR42nUpIwnbqOHAxVNHMkjQgWv/HDMtCBXpAeXFR3evRTEE8nmWG?=
 =?us-ascii?q?4Ht8pq/FsDCy81/XtfO2IvSeKkNJD3aP2Hvb5OEM7DNdDXsla6NXi+un?=
 =?us-ascii?q?vRBv4/YqrfT8ttQtbs8Uk/6g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 09:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681112030; i=markus.elfring@web.de;
	bh=9sz4KGiSHrUnIAFmUu/cuE/XF/hqY69p9SX8QJjSfuQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=vpHnlh5oTYrC+XLWqADDFGGfl+b2L0nkZXI4lLEyt/4KV9z703j1LUpe7wPmTu4Ti
	 YFuWn8LHlipEUoK4Gy2NcONVnOXw9jyhWoCZBKMVHDpPOdc42aamlP2CsHse7kyK+e
	 MQwjzOJH35M/6nhcwb3d3m5HF1qjX2M12L6Juj2sPmDtKrqTFf9w5YW766/rYTArpm
	 rrYy1r7ltOcosGi/z6CDkcJnbIAh13xeBenIYsK+4RflGmyKR/cKFd8zPjWw+iyzKG
	 waUpdeWw1rJGZ28ihMaei/iEWY53h4baJ3QhwDRSCJAluLohQ/9jSNRDUsH2KXqnVr
	 jzQSD8qM0l0rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1pcfEN19jV-008peo; Mon, 10
 Apr 2023 09:33:50 +0200
Message-ID: <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
Date: Mon, 10 Apr 2023 09:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rJRxWaa11dmU84JgzidzzH7lwWpwnixFfg/jkBs47Pjcy+bnu9o
 Vju45aXJg9c8RzejhdtDDYlIoccHXN4cNHwan5TMwFdrQaD+706IPfcBi1B0omg9P6+66Zx
 Z4dpfp432w5c5ZbqBhju8wazVm69AJ6oST3/bVrg0OkafZSEcIVceQRsT3QzXx4ClnsTP1w
 cYltkZJrjYWEIM4Aiev9Q==
UI-OutboundReport: notjunk:1;M01:P0:TgzRXdgKR3M=;p4szaAE4lkx1BGA3PraLRqPPS8t
 HMIya0Eu2HjabKTe4ZrFk7jhmlLGpndpx2Bfu0ONkyNYFsv9VqomIsK5AkcfKR4XPaSlrQP0T
 G2xNZiyVYStOSbeVeiyoCYFbbZ0ZH9n2Nh9cD3EClB24f+U5k11dvQZh3U3L6otni6rY48Xow
 ++l9yeUqDhNvCNtPs/LR4bpIOZhbmKCTYuL7QP69RX4B0kJSAAOrVDa54Nmw7PhJiFuvxr/le
 QNtIfUMNUrMH5ywmx/+radu3ywCWFClN524NZT5XT+mApulzsBa/wVm6VysLHmrUf7wC2n+4w
 PzcysyhVmS3LyYcePGCtfnRToHfOmFeE0GwE2S8U1QTxkSCiJ0bMnnYZPP13tPoORZX8eXbbr
 4arZWCyCU4qZX+OKZQQdsJ7FgYmmjHDY6qzyAmaM1iDQzBYGLtYZV6sNWyQFo/UBpZOq7gA+o
 Xe7E8WE3iohGAGSX0NYwzta2sdYavIap7dE5RfZH9vVI6BVbcNQCTk61qMLXmpB+utWUqvWxi
 q+pYnvEbG0UEKuvOnGEDqQeqVbxyw8tKpoMYfKkQPWi5QfDOzFbTXUFFGDr+//8TIWA4/putH
 lNGjlAEjGj6RL1QKKH9Wz05rONxtmPS5VQpgvC/qiAHjmtGc7owLtd7tIHMFqF7HjZum3ABz7
 pfno8ZEeqxXbH9S9TzAxnsn/qaS2i45eHQPHmoZeRoAluAeKiYiThcw7OBOJzrOq4hBPwdgNA
 0FkgNPklH29gNLRbpgmMVgeiYVtxy60eRcJ+c53npTWf0rMjcm9f9xLE+OBAA5Tga+7ywIAUA
 7Wuoaj9yae6x+smdnBED1UE/wyoLC/NJ2mYyxqCjSEIyOfslTjDge8aSvg9KeMPSVZgLTg7Jq
 /f3+hIyKyMBUYY3eb5Y/uzow7BTBTRfJhHYR1l/mAUkjgyoIbOPtI336T
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1019
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/2de88997-0732-d0dd-5178-f9d42b5a3be5%40web.de>

>>> Setting var to &input->member does not cause any immediate problem.
>>
>> Undefined behaviour would be involved if the expression variable =E2=80=
=9Cinput=E2=80=9D
>> will actually be resolved to a null pointer, wouldn't it?
>
> No.  &input->member adds an offset to the address of input.

It seems that we represent different development views according to the qu=
estion
=E2=80=9CDoes taking address of member variable through a null pointer yie=
ld undefined behavior?=E2=80=9D.
https://stackoverflow.com/questions/25725286/does-taking-address-of-member=
-variable-through-a-null-pointer-yield-undefined-be
https://en.cppreference.com/w/c/language/behavior


Regards,
Markus
