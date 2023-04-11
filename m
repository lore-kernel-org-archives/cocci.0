Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09873C76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vBFKbMQ6LtDers1VtZyn8FoqTCu0a/SI8WVRWHYX4FU=;
  b=RRhqURAMsi4OIlxM4NfM/ocLdANHBkUF9tZU468grII3SU7dB7nt6Pax
   7RsOR38460D32+IkS3UqKDYowJxwgOVy5Mj3aNZXFE9p+pdockzWfaO7F
   c05bTnAAUZP1zxpDaVGA7H6bwN2qj9361JyDgUEPu+UMEo+46ywyBlYPF
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102463275"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 16:20:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24337E7313; Tue, 11 Apr 2023 16:20:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C196E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 16:20:27 +0200 (CEST)
IronPort-SDR: 64356caa_Iwa9DaR2fK9H76T5cX+vVHuF5K1E199S1W13b189X3sZCm+
 N0tVFGpYZmrqahNfcIeRA+xDLyDUgm44dpoPnsg==
X-IPAS-Result: =?us-ascii?q?A0EsAABNazVkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORMIQwhy6HPohrgVaBQD4PAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?H8ChT0CHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHPgECAgEjHQEBESYBDwsaAiYCAlcGAQwIAQGCeoIoAQMOIwesZYEygQGCC?=
 =?us-ascii?q?AEBBpwLHywiVIFeCYEULQGNCYM2eicPgVVEgTyCUzA+HogBgmeOa4tECoE0d?=
 =?us-ascii?q?oEgDoE9gQQCCQIRa4EQCGaBeUACDWQLDnGBSYMqBAIUPCUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQkLHwZYawIsERMFAwsVKkcECDgGGzQRAggPEg8GJkQOQjczEwZcASkLD?=
 =?us-ascii?q?hEDT4FHBC9efAoGASYknmvHOzQHgiuBVoFZDJ8NBhMvg2oBkx4OBpIll3Mgp?=
 =?us-ascii?q?3+BZAE4gVwzGiSDNk8DGQ+OIBmEDI9IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23:w1LuUxNGYnlEcjOo9TQl6nYiBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6gr1g+VFtqHo9t/yMPo8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PTbglSmjawYrx/I
 Bq0oAjeq8IbnZZsJqEtxxTGpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohV
 bBXAygoPG4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vyiu4
 7ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQGZMWNtaWS5cDYOmd
 4YBDOQPMulWoIfguVUDsxW+CwmuC+zzxTFFnWP23bQg3ug9DQ3L0g4tEtQTu3rUttX1M6ISX
 PiywqbS1zXDbO5W2Szg44bHdhAhr+uMXbN2ccre1EIiEATLgU+KqYzmIjOVzf4BvWef7+puT
 +Kvimgnqw5qrzmh2MgjkZPFiZ8LxV3d8yhy3Yk6K8GiRkFhfd6kDIVftzucN4ZuTM0sTWBlt
 Ts+x7AItpC2YCsHxZQpyRLDafGKcImF7xz/WOueITp1mm9oda+hixuz8kWtyfHxW8io3FtLs
 CZInN/BvW0O2RzL8sWLVOZx8lm71TqRyQze6PtILV00mKbBJJMt2ro9m5UJvUnNAyP6gkb7g
 LOMekgn9OWl7fnsbK/8qZ+GLYB0jxnzMqQwlcy7BuQ1Kg0OX2+G+eSgzrHi81P2T65QgvIrj
 KbVqJHaJcIFqa6lGwJZzJsv5wilAzu4ztgVn2MLIE9FdR6dgIXlI1TOL+r5Dfe7jVSsijBrx
 /XeM7PmGJrNNHvDkKr6fbpn5EBczAQzzcpe55JSBbEMO/zyVVHqu9DCExA2LRS4w+D8B9plz
 IMRRXqPArOFMKPVqVKE+/ojI/OQa48NpDb9N/8l6ubygn8+hVASYaip0IAMaHG4G/RmO1+Wb
 WDtgtcHC2cKvxAxQPbkiF2YAnZvYCOMXrgx/TFzK5+jBJ2LEp6smrGa3GG4A5hffEhCC1aFC
 3CucJ+LDbNEbCOUP98kijksS7esUcki2AuouQu8zKBofcTO/ShNkJv518Vur8DXmwsz8zM8W
 +GUyWKQVCdZmm0SRjk59L9yqwpxxwHQguBDn/VEGIkLtLtyWQAgOMuZlrQiYziTcgfIf9PTD
 U2jXs3jGzY6CNQ4394JZU95XdSklBHKmSSwUPcOj7LeIpsy/+rH2mTpYd5nwiPj3bMikkJgb
 89BL2ygiYZg+gKVC4Oa216BmfOSfL8HlDXI6H/FyGOPuE9CVwsldKzfXm0EIGbSo8744EzqU
 LKkT7gqYUNa0cDXDKxMZ5XyiEleAvfuPNOLe2Wqh2K5HgqF3JuJa5f2PXoQ1mPRBSDoiig1+
 nCLfUg7Dyal+SfFCSB2UEjoaAXq+PV/r3WySgk1yRuLZgtvzej9/BldnvGaR/4Ju9BM8C48t
 zV5Gkq81NPKGpKBoQRmZqBVfdI65h9Oy2vYswV3OpHoIbplgxYSdAF+vkWm0BsSaM0ItMEwr
 24xiid2J7iZ1lxpaD6Sm5z9e/XWJmT04BGzevvOwFiNmN2S+6oJ9LE5swC55VvvTBB9tSw6l
 YUGthnUro/HBwcTT5/rB0M+9hwg4qrffjF4/YTfk3tlLaiztDbGndMvHuosjBi6LLI9eOuJE
 hH/F8oCCo2gMusvzhKMZwgHIfsU2ao6JcKgeNOZ1aTtMOsqz1fExSxXpZtw1E6B7X82b+fS3
 Isehdyc0BGGUTjUk1qr9Mz609MhB3laDi+0zi7qA5RUb6t5cNMQCGugFMaww813m5/nX3MwG
 EeLP1odw4fpfBOTawa4xghMzQENpnfhnyKkzjtymjVvr6yF3SWIzf6wPBYAP2dKQiFlgzKOa
 cCRhsoZQVPuQgwnjhqj6m7lyqIdqKk3I2TIQEhOdjT7NCk4C/H27ODdJZcSrs9guD4fSOmmZ
 FGGVrPxxnlSmzjuGWdT3nFzdj2nvIn4gw0vjWucKHhpq3+KMcp0xBrZ+JndXasLh2BAHnMnz
 2CKQATvWrvhtc+ZnJrCrO2kAmeoV5kJNDLu0ZvFriywo2tjHRy4mfm33NzhCwkzlyHhhLwIH
 W3FqgjxZo7z2uG0K+ViKwNNDUX/9tE8N4VwiIo2i7kP1HJcipjfrh9l2S/jdM5W367zdi9HY
 DcRwMPOpiXh1ldiKH2h2I/zEHmQiJgEBZHyciYd3SQz6NpPAaGf4elfnCd7lVG/qBrYffl3m
 jpOgetr8nMRhPsF/RY81ijISK5HBlFWZGa/8nbAp8D7tqhcY3yjNKS9xFYr1870F6mM+0ldQ
 CqrIM54W3UqsYMmagyKiSejrdu5HbuYJdML6k/Oyk2G1bIKbsts0KJN33cvOHqh7yd8kahh1
 0MohM785M/ddC1s5P7rWEcHcGKvIZpCoHe30fYZxJfzvcjnH409SGVRGsK2ELTxTWNU7bO9a
 U6PCGFu8C7EX+WFW1XHtwE+6CiQW5GzayPNfSZfko8kHUjHYhIDx1pKOVdy1p8hSlL6noq4L
 ho/vGpAoAej8lNN0r46Z0O5CzmC4l3zMnFuEtDaJR5SpGmu/m/zNsqTpqJ2FiBcpNi6qRCVb
 3acbEJOBH0IXUqNAxbiOKOv7J/O6brQAO32NPbIbbiUzI4WH/6V2ZKi1Jdn9DeQJ42OOHdlF
 fgyxktEWzhwBc3YnzwFTyFfmTjKaoaXoxK1+ys/qc7akryjQAX0+Y6GEKdfK/1q/A2qx7iOP
 aiciWcxKDpV0I8N2W6dyLUb2w136WkmfD2sHLIc8C/VGfiJwOkNVUFdMn41aJgtjep0xARGN
 M/Fh8mg07d5iqRwEFJZTRn7ncrvY8UWIma7PVeBBUCRNb3AKyeYpqO/Ka66V7BUi/1Z8hOqv
 jPOWWrqJDeejH/EUx61MOdDpD6WNlpStcvuF3QlQXimV9/gZhChZZVviiYqxLQvmn7QHWsbL
 CQ6bE5H6LGdp3A94L03CylK6XxrKvOBkiCS4rzDK5oYhvBsBzx9i+NQ5HlSI1p96SZZWLpql
 SGUotM8+zlOd8GQxzAhXBcc8l6ja6qUsE8kNaiLr/F9
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:dpSDGapDlI7E7mcF+j8+f2IaV5r/eYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102463266"
X-MGA-submission: =?us-ascii?q?MDEntC+jrHhaWzmX4en7gwZNm1Ghi9fSS8EEhU?=
 =?us-ascii?q?XjV8iy4Bb6ANaJjm7e2oTbjX2JYO5eE09lKLm8ZcEdopC//wQHHVqkMF?=
 =?us-ascii?q?MXYaNAgxvD3yQZW0qoWzw71ld+aj+KA0lWXhitqQ5emKXAF5CAfR2TAr?=
 =?us-ascii?q?Jc39QAYflY3QdIKAfDY9gaXA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 16:20:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681222810; i=markus.elfring@web.de;
	bh=vBFKbMQ6LtDers1VtZyn8FoqTCu0a/SI8WVRWHYX4FU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LgyldN7GweqmuUXrIsLpBD+H2mjbugAWNRaeQOzPywnxC3fLklkSTd1dU43tvclbn
	 tWg8WbecSNxeEKi1EBItHmwO4bt/crpDwjQl9XyNz1XdA1DUnWnzWorRtRMZ7GLPgv
	 bV8vyCWzOyQn+wl5aM3jBSai2Nxt5bczc/S+wfJO9JXTcJX25g+BBulitBC1XIZsNY
	 NKpL3tinQxjQiWM/SuEJcbdnocQM1GhrTayJT031cI/TmTV/rGVi0MN43kBdP/R5Xc
	 kJOwiMMxPl2TA5lY8aVGjDnA51XyjNmjNQeUtLn0HPnhv4DPNUvjTeBpfliPIS0YX4
	 XGQpnbrpPDbuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1qL1NE18A2-00b9eG; Tue, 11
 Apr 2023 16:20:10 +0200
Message-ID: <f981d141-ec14-fb62-9d92-ca7cfc05da5e@web.de>
Date: Tue, 11 Apr 2023 16:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
 <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
 <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
 <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
 <20230411064051.qyioheeoectj2lv3@vireshk-i7>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230411064051.qyioheeoectj2lv3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KqCTT5ioYXCwDjE3CDPpC7yFteDYphQJ27rNRb2p1LSAG5/pkBX
 cvHbh6TkZtl57nD4tIqvoXDcmRiXb3Iarg2K0ecy7qf+HC1NR/L/BrGdiBb1T8Rj5XwK7G6
 lQDFh78wUSUvTz845s7kFt0kXAMxZfxD7kJeKsuVPY6VoKWPqUe3lFKbCEndAakq7yfl31h
 otmEvHZq0Crcv0ZTY+o3w==
UI-OutboundReport: notjunk:1;M01:P0:65yHN3BIzuA=;rwMiVt/gMprvcscGqpwAx231spi
 WdzADqd1+iRl36pJWG8zURA8V84VxopC+Y3fxIE+s81R7bbrMDf4aDkgAntQ7GEdxjRpcZGDn
 1d7V/vyoH3ldd25PLdl1wszKfScgnL7kHzum3a2JFkwrPb23sSaoAFzYsBaqynqASaQULKuhr
 5hdWnibdxzuwLA2wOXS8J8l4/lQDAsFNPAso5I53JKFX6I5159cMpFyFqUKe+g4JOTmefhiBN
 Ol++8Gbis0iRu4uW6rSv6jiMuspeBZ5v7BtzB03tqrDpCfolVnQlp4OnZ10XVmoFrpBWS60Wo
 kYYEE4PRXpHS8paDYKJO36+vhpgEKNJQKTltbtCQjZkfL+gBJtJdq/3prnLkIfsbDKoJWVgs3
 uM77RXwZDFIM3i/RyBnnTByfe30GBljeuBKYs5Q7wB/2fyM0HsK1mpG+E0lt+do9S+s8tvqn0
 zREWi+L/GBPW7sooNm1af+SEcS8PLnFKI02eQXKkibR/BLaRWuKwNPX9XAMQA9p1hP/VNUgr/
 Bdg6BbxVuCcD1PLXQIEd7fhhUWc0yEK2ydyoMzJ/selMTcI5ZRoKzCwSOl9Klh0IAafbkCfqf
 cuQpPZuAadpDcmqf7SVSc1tgurlXxHeUREQF1z5M/Ez+4s2yIyKLixvT2fUJKubq2naFJAHUy
 c2XPavjORFyKS7JIH0RBMVA+6YO0RDO9p4xmJtTOWv7Ak77NaIvlxJ6oPBh4tyLp063zgAh6o
 Xbyzd4nkLl7ScpSvTd1zwx8lkA03v/ZW7775AuXPXEYDMzrbl9/IBYl7+Q0sENJdNTxAdmQDz
 TdSN8DQ7Zg9OSu30JY+3GKm47bZfyg/QyB4dsHoT+Izv/3AH1BNJwe/uBgOKHnaDSGneGTlMf
 ZmbF3LKpgteqTPMJlPa4HqXwJz+/5QK0Gco4fq2Pptf2Shgfn/UEtNuUQ
Subject: Re: [cocci] [v2] cpufreq: sparc: Fix exception handling in two
 functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1034
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f981d141-ec14-fb62-9d92-ca7cfc05da5e%40web.de>

>>> This is what all should be done for these drivers I guess. There is no
>>> points doing the dance of {de}allocating resources unnecessarily.
>>
>> Are you going to integrate your source code adjustment according to
>> reduced dynamic memory allocation?
>
> =E2=80=A6, else I will do it.

This change suggestion seems to be based more on your ideas.
Thus I would find it nice if you can generate a patch accordingly.

Regards,
Markus
