Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADE1C43334
	for <cocci@archiver.kernel.org>; Fri,  1 Jul 2022 21:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wuFOo3MfRFGIyy85yCFlX2CpQ9rZGyZQKdmYgpH9eK8=;
  b=CzHHACxjvaaQVE8uuNMxTvXEG6whVh5Aq0lvKaF2nvBgpydtRGhGrUdM
   4Vw8HceFvovl4MvkmXvbv3p8+UCMQfHrJP/09FKJkArUkfqhj1GI2mfMH
   ZsX3LLkzhPV3AH1vanjt9gX0u4gBJCaan3alHq5M8Ke6JFv69z3HIKVpu
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="43897304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2022 23:13:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30A15E0092; Fri,  1 Jul 2022 23:13:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 260ACE0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 23:13:38 +0200 (CEST)
IronPort-SDR: kUB2dkKhXN3qVTnginhMwIprJOFWDIjPU1BYix596CPyzoVUkREHD7lTHaJiDvKKxbTPNLmfts
 gkM3Fo8Xag42FFvWlPxH6K9uYu8PfI7EG9XuYzNy8c5LiB5dtkVlW+f+8VWgveu6nV3JXs3+yK
 EQDCQFKrh9S5MtLDLdGNzbOu72Sir6Mc6yTkMp0HBbrL7sBNXZYteAKrSZ4INw6sX33n9Dmiir
 zDP90w2g75CTCGw/YNh5QFp6NsWFykWLi0/aM2dx9sXsRqdbLOVcCxHXHVT7G00TqDJK59XvIh
 36vuHXs2jPpj5Dkpo2tG2yH7
X-IPAS-Result: =?us-ascii?q?A0D6AQBAY79ihwMP49RaHQEBAQEJARIBBQUBQIFPgiSBV?=
 =?us-ascii?q?y4EC0SETpBfMYQjhw2HHIwjCwEDAQ0/AQIEAQGCEIJqCgKFSwIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCe?=
 =?us-ascii?q?YJlAQMNIwetE4ExgQGCCAEBBoRLHywiUoFcCYERLI4CeicQgVVEgRUnDIJHM?=
 =?us-ascii?q?D6BD4M1g1aCZZovJgQPAxotLxKBH24BCAQDAwcKBTAGAgwYFAQCExJTHAISB?=
 =?us-ascii?q?QcKGw4UHCQXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALAgMWCQcKAx0IChwSE?=
 =?us-ascii?q?BQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLAwUPDQEGA?=
 =?us-ascii?q?wYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCAhsHAgIDAgYVBgICbi4NC?=
 =?us-ascii?q?AQIBDckDwUCBy8FBC8CHgQFBhEIAhYCBgQFAgQEFgIQCAIIJxcHExgbGQEFM?=
 =?us-ascii?q?icQCSEcCh8KBgUGFQMhbQUKOw8oNDY8LB8bCoEaLCsWAwQEAwIGGgMDIgIQK?=
 =?us-ascii?q?QYyAxUGLRUVEQYiARsCm0txgRdylCyuVTQHghSBPYFEDJ4xBhMtg3WMQ4YeD?=
 =?us-ascii?q?gaRepZzIIEHphyBeIF+MxokgzdOAQIBAg0BAgIDAQIBAgkBAQKOHQwNCRWDb?=
 =?us-ascii?q?ootPzQ7AgYBCgEBAwmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23:D1bOdqpeBWABtKN64Z1wXPd+IvleBmI0YxIvgKrLsJaIsI4StFCzt
 garIBmOMq2LazCnLYh+ao/gph5X6pOAy4MyQVZopSszH3sa+OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0ILR7z+l4
 4uo+ZWAYAb9gFaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSZeDUMLLeTwt8ecBwHOQ1eI45EpfzYdC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KZecmpSKEnewbneLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwgGxg158VRa62i
 8wxThFBRSrATDB2Bk5NLMM7tcaonlT+fGgNwL6SjfNqvzaKlVIZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXPSbwCWM9naElO7KlznyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQ9yxgLv7JtrneobdyidTGYvl2G410DDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiCPQbWNyv
 rNut4ywbQGDoIF5WlrBp+/M9mja1Tw9fTNYOnNsoR4tvoG7yLzfmC4jWf5PPcZZZPXWECv02
 CqXrCVWa1470pBSjPrTEbzvqTugq56McaXh/BnLU2ev4xl2DLNJiqSt7kXHq+lNJsCVQzFtX
 UToeeDOsoji7rnUxURhpdnh+pn0tp5p1xWC2TZS82EJrWjFxpJaVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYib0MvcvOdnqVZlxpUQFKTgDfq+LBjapSschHDJrAAkyPCZ8IkiwzBlyyvtX1
 WmzK5/1Uypy5VtbIMqeHrpBj+ZymEjSNEuKC8mzzhK73KCYaWLdQLhtDbd9RrBR0U9wmy2Mq
 4w3H5LSlX13CbSiCgGKr9J7BQ1UfBATWMGuw+QKJ7XrClc3SAkJVaWNqZt/INYNt/oOyY/1E
 oSVARIwJKzX3iGcdm1nqxlLNNvSYHqIhSlqY3F0YQ31gCRLjETGxP53SqbbtIIPrIRLpcOYh
 dFcEylZKvgQGDnB5RoHapzx8N5reBix21CRMiDjbDVmJ8xsQAnA+9nFeArz9XBSX3Tt6pZk+
 +WthlHBXJ4OZwV+F8KIOvih+FOGuyRPkuxFWUaVcMJYf1/h8dQxJiGo1q03LsgAJA/t3Dyf0
 wrKUx4UqfOT8ZA4+p/FiPnc/YuuFuJ/GGtcHnXatOrna3OFozD7mYIZCbSGZzHQUm/w6Z6OX
 +QNwqGuKuADkXZLr5F4TeRhw5U+0N2z9bVU+QJpQSfQZFOxB7I8eXSL0JUdtqBJwbMF6wK6V
 ljWo4tfPqiVftzoGhgdKVN9POiE0PgVnBjU7Og0eRmrunUooeDfCUgCbQORjCF9LaduNN13y
 +kWuPkQt161hC0sP4vUlStT7WmNcicNXvl1rJ0cG4O32AMnxksbOM7ZDTLqpo6CYZNAPxByc
 DOTgaPDgZVax1bDKiZiSyKSgLAF3Zle6gpXyFIiJkiSnoSXjPEA3CpXrWY9QDNTw0gVyOl0I
 GVqaxZ4KKjmE+2EXySfs71A2j2tBSF1PmT0zEYV0nLURQ+kWwQh6YH71fmlpCgkH6B0J1C3P
 410DE76XDyscMyZMu4aRxt+s/K6JTBu3lSqpS1kdvhp27ElbDCjjqLGia/kbff4KZtZuXArb
 tWGMAq9hWMX+MLQT2AG51Gm6Ikt
IronPort-HdrOrdr: A9a23:05IUqakz2cdZJl53I8JBPifFrwfpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="43897300"
X-MGA-submission: =?us-ascii?q?MDGMzSVQdWA7wt4po9KTxGceq5Hc4TinZqZO20?=
 =?us-ascii?q?wQr++EdYThx7aqJQrIRpa6rlYzoYrU5dl6MR+xRZu8QPI9Rpgmvz8UBr?=
 =?us-ascii?q?pwH1nhz5nS01/76v0TYk7NjVYJUakCGu+lmdFoh2oNkerSZ3x5/W2/SS?=
 =?us-ascii?q?+1Ji8GAN6mjgFbXvuV3cPWbg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 23:13:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656710015;
	bh=wuFOo3MfRFGIyy85yCFlX2CpQ9rZGyZQKdmYgpH9eK8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mQYoR+eENw4OsIHqEwkJ+lT6IsXyO6hdrKUNzRrEM3cZpF8FqaOrHEuxjknVsXfDq
	 A1zenokSMdhEAJzw340ByDLFdGt3qxpXxG8apj3q5mvATg4RhudlC8PRSO29CMqcye
	 iU2PvjnvQ2AghNZi9lIQVIwepdv+ZJrnjAVSyz/M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.132.48.14]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1nSqbL2m3g-00ejGa; Fri, 01
 Jul 2022 23:13:35 +0200
Message-ID: <d4797cd5-1412-e6af-1f40-d5e094b1acd8@web.de>
Date: Fri, 1 Jul 2022 23:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
 <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9I5lqCZkFbJZZ/I4w2enLlfQ/RoL5ZmrnaCRs3nuONDW71OC2Rv
 zYZOWukseclu0P5LG47TpXZ17o8wGi12fAc9o1hW+YZD8caLKdMgSpk9LvIcOyv/YsjwWNR
 ZIsYFNEwNWMyCdDHv+tOHGtlTjDZMbZuFkw3+xzpH9MrBDGUzUjHjnhV+iTOnn5mMyI3dC2
 t6sw8jsMzBnrAgF1cRYcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k/0k87AADCo=:vy8eYUj576y/LhM/dFPply
 /+oaJR0Glk2OcvwvL5oq0QyGts2WA/dgFYgI3o+ZTKewIOTscJnR29RN+2y1KCbmzPxdJoXPN
 HjqQzxMetbq4G1N8wXpnfvYieIIezM2mV7Sw4w+TwunkskSNj3IN9rJnNHV3iAgq/I/ykZgFH
 qSmvHFfzI5pfuQZlf2/3zo2dea724sQah/OhK7rg9TuKJdu3alkQ6oK9RMvQRi7KVIO7CtHnd
 A3kEC/KnxfGiKhtp9f2EKJaKlrMRmVx/+mH4cmCeGT7QE/MAOOntqLHAU0O0OAo3cPA/PptHH
 YcdR5ox/uQ4n3QboRP7CbvU2brQiJbVk0+FcfIDB3tvvTOCzbZ9ov+TrnjnwfTenmKDtGdU3U
 pmImx74suo6z4/IQuwEgTyQTmeit7AcOifPMsBm9eMczPDNRLE5Q3DfmgShYF5PqPM9XLvrQK
 HW3CsefJOQKqOO5XRM6k8B3xjnyPTMgYM2lEGClynUhXi3isoHzwd3QtGvBNmeePQ9sTMbyoZ
 5bg4MNeHHNSM4VibqhaIYrLLh6XiF5f9R86QNowvY0+bdoFaYniIp3GA2g1CW8qa260LJKexs
 95X98GNLT52qvmRRb7a/8uu4WqPNqxT0LTvOKFWC5V3EU2i1PZL5N+FeRV4xWqptu7zDo7gCE
 ElK61aafNPq+L21ekCliHvZvwCwCHYxlyu8dGxa0hBsxIfcLlbglfF6wl/hlFIzxWhMAYjr8R
 iq7i6rEGKvHxaGsinHofjO5Pob0ufDc0iizPiwwxN4p0uB7nOObQMvtbgemyjOgeYbPwUUKcj
 Z0CfIoDVvTKB+w8qUBzi9R8VRekKj2l5Q5QqHY2RxOK7iUvpBslZZSCo28/cIwGW71S7ZM0ic
 vDx7TXp18EttUVQRabtjeb46vDVdfsoRlIbYM2wWXPXXqUWc/U+8d9LlI/F1wkg/kbGNRrsZI
 d072+IYku6GZquvrLFQomWLkDmCDh/dMQ7nFUUxYao41vNJO9oprn2rjS2ObBIgoe4svuZfXa
 /GSJSIg1/XdemC0qD/IHJKpK/qr62cqlHG331hiwx0BXbNGGgdaG6ilxqcAPKJNdEjwAGR+pB
 wEwePCUFh8tI7uS7XrjZ+IUXfKcR46iQ3eq2Pe8q4qDdjfEGrG6xD35Zg==
Subject: Re: [cocci] [v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 475
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/d4797cd5-1412-e6af-1f40-d5e094b1acd8%40web.de>

>> Can another SmPL code example help with the clarification of proposed
>> implementation details?
>>
>> @display@
>> expression x;
>> binary operator bo =3D { =3D=3D, !=3D };
>> @@
>> * &x bo NULL
> Markus, did you actually try this?


A command part like =E2=80=9Cspatch --parse-cocci =E2=80=A6.cocci=E2=80=9D=
 will show a bit of information
as usual.


> Please try things before suggesting them.


I suggest to take another look also at related SmPL code variations.


> The whole point of the proposed change is to trigger some isomorphisms.
> I really doubt that any isomorphisms will be triggered with
> this suggestion.


Will such a desire influence corresponding descriptions any further?


Would you dare to follow the presented design direction any further
so that even the explicit source code filter for equal/unequal binary oper=
ators
could be omitted (according to the combination with the address-of operato=
r)?


Will any related software limitations be adjusted?

Regards,
Markus

