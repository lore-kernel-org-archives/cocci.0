Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D780C433FE
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:54:41 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24872966"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:54:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D795E00BB; Mon,  7 Mar 2022 21:54:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48725E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:54:37 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: I179s63lJxmQxlOhOImJ436KjL9sm+BZbziUa67XwFBLMhL2eRQ9bnFbftlHdnBhxD17IjXcRS
 GeJRuTuQauwFfXI7MkkEog6k+Kd5fJ9MZR2GW+1k+/3Sr0Nun5V5ASDj9IF9EN88rUfby/12xF
 dbV5UtVu73Af+7kl2e4Z1woHVrsrokvfOXqzzJy6BMFGC00YAJcWuRC4lLTKtLR3ybwKmEXP5S
 LvrvkEXCAgjxNDTsaJhCJ5XaHuGTCmB+lHfiruDgnSU7XHz3gOpyztFy79fmFYnhjeFSrSkznr
 2AQEWLSqjVSBuzIOjTd2CFLf
X-IPAS-Result: =?us-ascii?q?A0AQAAA3cCZihwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInaRVXKwQLRAKEUogmhk2BdzGSOYomgXwLAQMBDTkFAQIEAQGEQ?=
 =?us-ascii?q?kUChB8CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBA?=
 =?us-ascii?q?QEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSKDbAECAgEjFQgBAREmAQQLC?=
 =?us-ascii?q?w4MAiYCAlcGDQgBAYMAAYJkAQMNJQuuBYExgQGCCAEBBoRIHywiUoFbAwaBE?=
 =?us-ascii?q?CwBjkcnEIFVRIE8gwM+gkwXBBiBRoMagmWVTYIngU1wwCc0B4ISgTqBQAuJP?=
 =?us-ascii?q?5RMBhQug2GSVw4GkV6WVY0TmWaBYYIVMxokgzhOAQIBAg0BAgIDAQIBAgkBA?=
 =?us-ascii?q?QKOHRmEDIRhhUtANAIBAQEKKQIGAQoBAQMJhUcBAYwmAQE?=
IronPort-PHdr: A9a23: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
 XmKxuM=
IronPort-Data: A9a23:AS84eKJmoq0qvF8SFE+RqZMlxSXFcZb7ZxGr2PjKsXjdYENSgmMAy
 jcdWWqBO/aONzD2fdB1O4u0pkpTsJfUz4UwQQMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvS4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhsuBM4
 u1ch7OLcEQROfLxvtw3Vj5XKnQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 LpEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacqfE/qQtIECtNs2rpF1MvGBW
 e41VRVUcR76Y0VDM25PK7tryY9EgVGmLmEG8QvLzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Ar7E3/RBxYHKJqAxDDD/n/EavLzcT3TdbIvPoWpxNFRuR6rwTMuLiU8UHy0mKzs4qKhYO53J
 0sR8ysoiKE98k23U9XwNyGFTG64Ug00BoIMSLdmgO2Z4vWEulbDboQRZmMZMLQbWNkKqSsC+
 nLhcznBIDtprLSfQG+Hnlt/hW7sZXFNRYPuTRUEQAoD59DlrMQLgBvLXL5e/EOdi9roBXfvz
 jrMoCVWa1QvYSwjh/jTEbPv2mzESn31ougdu1S/soWNsFkRWWJdT9b0gWU3FN4ZRGpjcnGPv
 WIfh++V5/0UAJeGmUSlGbtRQu/2uKbdaGaD3TaD+qXNERzyqxZPmqgAuFlDyLtBaZlslcLBP
 ROC4lwPjHOtFCHxPfIsC25ONyja5fG9SYq8D668gitmO9YoPA6B4Cx0Y0OMl2ni+HXAYolvU
 ap3hf2EVC5AYYw+lGTeb75EjdcDm35irUuOG8GT50n2idK2OS/OIZ9YYQvmRr5itsus/l6Km
 +uzwuPRln2zpsWlPnKImWPSRHhWRUUG6Wfe8JQGJrbeeVM9QAnMyZb5mNscRmCspIwN/s+gw
 513chYwJIPXiSKVJAOURGpkbb+zD59zoWhlbzMhNxCk1iF7M4qo6a4ecboxfKUmrbAyk6QrE
 qNdI8jQUO5STjnn+igGacevpoJVdCOt2VCEMR2jbWVtZJVnXQHIpoTpc1K3pikDBya6r+Ukp
 Lik2l+JSJYPXVowE8vcLv6ilgvjsX8YkeN0fk3JPtgKJBSyqtc3cXSpg6Zucc8WKBjFyj+L7
 CqsAE8V9bvXvos40NjVnqTa/Y2nJOtJGBYIFWfs67vrZzLR+XCuwNMbXeuFIWLdWWfz9Pnwb
 OlZ1ailYvgAgUoMrId2VbpmlPps69zqrr5c7wJlAHSSMwX1UOw9eCHe0JkdrLBJy59YpRCyB
 BCF9O5aDrPVasnrJ1gceVg+ZeOZ2PBIwTTfsaYvLEPh6HMl9baLSxwLbRyLlTAbM7Z/do8om
 L9ztMkT4g25qxwrLtff0nEKrTvRdCRYXvV1rIweDa/qlhEvlANIb6vcPSmqspuBXNNBbxsxK
 TiOiaue3LlRyyIuqZbo+aQhAAacuXgPhPyO5FoFOkjPhdfPwPM6tPGUHfLbUSwNpiirEcoqU
 oSoC6GxDbqD9XFkiaCvmkiyThpZCkTxFlPZkjM0ea6wc6VsfnPAJisxNI5hOazfH310JlBmw
 V1T9IopvfsGsi08MuvelHOJc8DecOE=
IronPort-HdrOrdr: A9a23:Ma4euaBA8zzSzm/lHemI55DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3OD1KbcdKMLsytHSuQ4y9QYWcelSAZsQkjuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24872962"
X-MGA-submission: =?us-ascii?q?MDE3pj90ZqT2YY2vDHhLHim0esfhMqdgPdKIud?=
 =?us-ascii?q?WaQlckDiwfzKskACgTkDX3QQAM6GxYt6ZaH7WDjo3SnUxV0NKuZlKAmm?=
 =?us-ascii?q?cpb3qSc3C2HscgVThgNUNqOcLPoAeLNgCZXRL9iVcITr5/J4DT3u1dTW?=
 =?us-ascii?q?0EM0SmplTPLK6d73e9c6GMeA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:54:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646686476;
	bh=PiysZL9c+l7IHt6CjlccXRpQmWcokDQWesYDiuMkSYM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Nf8zMjVrhQskb/hpcKvxSMj3uS+EMKn7C7pFOncbPts5GPfK6VoZAjvFKI8pikHpB
	 WuPbqKM+LfrsQirQg9AcEp+RE6BI2z+pdl1kWWaxc45m0+eOyRPilQd2CE+FXbOlqq
	 Rhio6GdlfQV17WVQrrUcmlZonwMRlEoix2lkNliQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.71.136]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1oEr6O0GFQ-017ax8; Mon, 07
 Mar 2022 21:54:36 +0100
Message-ID: <c147926e-d46a-30fd-3efd-a5886eb2dd91@web.de>
Date: Mon, 7 Mar 2022 21:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net>
 <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net>
 <alpine.DEB.2.22.394.2203070900200.3091@hadrien>
 <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8T8dhjqIMKRdI6XfHdiVhJ/PgTcDcboqyyySBfRDcdFfWsJD7B
 4hQssQ7lZ415yP6T4xM35NMTTmils2q1/pxOHAPEQFn3dJgvoCUVCJt/W0rUdHlzS6aig+g
 8Oyyl5wfvWscWqG7sD2Cw+fG976phlAk2xUt1jnpZc5+kDUm6FfM1DVoFXCuYup+8sEK+Vk
 9aVP0L++19HPQIZs7ImPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQXu50o82vI=:5G39F7ZEuK3WEt00SJvlNz
 QnqfvZFmiR0/N996rCB0NC5sHNplaASoDWVsvfTHV602QuLI6IRPFwr1BpbGD3wepqS/OZj0S
 3TiIlhc6N10ibLRUAl+GL5SHwZU/7Aqs8X4MqvcT9XisiXiRiJQWjv5DoMFf1GBNA5i4iZDzt
 R0xMkRWmL8PT5nsHwTjR3PK5oqACH1GkdBDKmXH3aZoZBjY88gKqEsKsPDR6f3CWhueyq4FZQ
 lZYyD0KZc3hbsxnUxui5ePVXrrfDFE4pTc5zBkJg8B5LhzZFf0ifY2riv38xh5mb0cGoZEUYU
 AEIAbWcOjkywv4nOlSEcgpaoWH9Daw0Kzn0s9ynfVIqJvrposh3ayi5sd9bB63Zz/hNDg9W/7
 YpepV2rlbbx3xN54n7AShW+C8XTaJ+4UZrDda84bpq7hqxCYdZNmp5J33gxVtQwnhBPL/hWC6
 TKgPgj5y8GZCg5P8XAEs9GZpG8XlXmYGdYgg9Dap+p+4e7Tlmf3583cN5LnnkmetAVnB4mSKH
 olvc1Wr7/OrjyC9aXkN2rhVFELRP/7zUQ9HjSkMolKRBj/3CPKEgzQSM/ZeVuqB9Xqy7Y37bn
 pkGN0z/zFmqibWs0jvOg3gfO9f6ybYCMbAQ3xuKWJs+TFiKprOs1QVMxZruMc3nX1rnC5aX/b
 RL431B9TC0KywrFrJLntmgzu27BZ6sQ+UtAq1Z2rWYaYKuXd4KB+xpEzuXSJRuGcKrT0xwJWY
 lBzEjCv8qexQQSxWAYLlQa68XgeQsVTD3ts0hj8HsRjui6eLpYig87FUgS4q90Eax08fxoNlo
 wPVrDc1xDlUxW8klPiTXbe/r2EDjUiF2lFhlO2kNAXwRIzaAVImSn9jDpfe2o6ieAUBbOv20g
 AXuVhNfIyQaAxDRmNTBBHLkYI/Vc769tZWTVak0td2YpdG2WU+t+aJRXh3kJp8rWKAAw3xlpL
 alk/VZdLJUN3eKTb6EUrCm4qFN0QHC+vIqKkNHMPbin+DrnO56V0GzeLj3hOEN2If7+YHb1YT
 kmKT0hqCTGoNS469ICtngK/npNlN0KRa0QNahIDjvsp/vQBtpBQBZBGTTwMVaKZOzDi0jnycx
 xqvcK8OAoFKz8g=
Subject: Re: [cocci] [PATCH v3] Fix support for "complex double" in
 parameter lists
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 182
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/c147926e-d46a-30fd-3efd-a5886eb2dd91%40web.de>

>      Patch v2: Fixed: strange type2, maybe because of weird order: compl=
ex double

=E2=80=A6


>      Patch v3: Added signed-off-by.

=E2=80=A6


I suggest to reconsider the detail if such patch version indications
should belong to the patch description (or not).

Would you like to take another look at advice from an other information
source?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Docu=
mentation/process/submitting-patches.rst?h=3Dv5.16.12#n705

Regards,
Markus

