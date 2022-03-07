Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8D2C433F5
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 00:08:12 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24660967"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 01:08:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01005E00CB; Mon,  7 Mar 2022 01:08:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F4153E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 01:08:08 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: Mj/hcjVAyHFH7WYLDa7XAwNrpipK9umaPHjjCDz/iicL3R4SunamZyQWIMMjvkzHbX17YitC6J
 kNJHmGZVqe/gGegZjHdr+QaJFFAr4iBm4sFqc+Zi9B61y2EiTYx6cnFf+LHEeio9Tz0mSG1a+Y
 8Y/+mG0v68I6YYxNgCv+3axkgBqkJy8QywBcl1AcLeoWpSEAumRYqhHET2VMZUf/c0vqzgTFu+
 4ibdoBzhXEoHtAuT1KuwT1d/afIKiTJlcYIcJB5C3+yyVBwXJIFx0yD+7iAtd8lPfrBojnnf5W
 lQvvsjni/oei/F8wrrVHqUgy
X-IPAS-Result: =?us-ascii?q?A0A5BQB8TCVi/0Xcza1aHgEBCxIMhEIHd1YBAQEpBAtEh?=
 =?us-ascii?q?FSOc4IonlsLAQMBDTkIBAEBhQcChBsCHQYGRwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBDANgjUpAYNkAQQBIwRSBQsJA?=
 =?us-ascii?q?kICAlcGgxcBgnUhD5AtnAx/MoEBg08BhiUGh1AUQoMphDUnHECBTYQ/PoJjA?=
 =?us-ascii?q?QEChHiCZQSXUBCCTpI0jzBUnhKDU4sKlEwaLpZEkWYtliiNE5QuhTg1gQo6J?=
 =?us-ascii?q?IFZHxQaCCYKgyVNAQIBAgEMAQICAQIBAgECAQgBAQIBkg6KfyABAQExCy0CB?=
 =?us-ascii?q?gEKAQEDCQGBVpAoAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:07zIqaufpZEIcBh+Gi82+dbOPefnVElYMUV32f8akzHdYApBsoF/q
 tZmKWmOMvqLamGgf9Aga4W0oxxSvpGGz4VjSwpurilnRiMTgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5aHZgf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnczzaQc3HojUobVeWEV2ShBmZPUf25aSdBBTseTLp6HHW378hfhxDEw7OYACvOB6HQmi9
 9RBd2tLNEjewbjsmPTlG4GAhex7RCXvFIgYsXph5TXYFuo9B53cQ6jH4dJCmjE9mqiiGN6EO
 5RHMWsxMnwsZTVzJFUxDLk+od23uWK8LBd/73TSo44otj27IAtZi+Sza4uKKrRmX/59lUGTr
 WPu5HX8GhhcNdqFyDPD/GjEuwPUtSbrHo8NFLC18vNwxlue2gT/FSH6S3Pr4tm5lG6bQ+sOa
 EdI1HMftfFqrW+CG4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83zt1FlToXRYaN4N77J5eqSgCk
 w7Wz4mwVFSDpZXMESrFnop4uw9eLsT8EIPvTSoUCwYa49TupIwpyBTCUr6P8ZJZbPWuSFkcI
 BjQ8EDSYon/auZSjc2GEajv2W7Em3QwZlddC8W+djvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iRaxpnFt7heXMHS/MBofAnqNOr2j8tpzRWG3AAH82cJqFxBBEJPjagLvG8ldRg5Wir1UTL2Y
 ELevQ5L5ZlYeSPzBZKbkKrqY/nHDMHIS7zYaxwjRoEWM8gpKVTep3kGiIz59zmFrXXAWJoXY
 f+zGftAx15DYUi+5DbpFeobz5ExwSUymTHaSZzhlkT11buFeGXTRKgFPVaKY/p/6q6Y+V2H/
 9FaPsqM6hNeTOynOHWMq9ZOdAxTIChpH43ypuxWavWHfFhsFlYhPOCNk7kvTIpowvZOneDS8
 3DgBEIBkAjjhWfKIBmhY2x4bO+9Ro52qH82ZHR+PVuh13U5T5yo6aMTK8k+cbU9rbwxyf9vU
 +JDdtqAD/lLRy6B/TkBNMGvoItnfRWtpASPIyv8OmRkJcY9HlCQ94a9LAX19SQIAi6mjucEo
 uWthlHBXJ4OZwV+F8KIOvih+FOGoiRPkuxFWUaVcMJYf1/h8dU0JnWp3OM3OcwFNT7K2iCei
 1SNGR4dqOTA/901/d3OifzWpoulCbIjTE9KWWTE7bu7MSTAuGyu3dYYAuqPeDncUkLy+bmjP
 L8JlKukbaRbxVsa4ZBhF7tLzL4l44W9rbFtzjN7QCfBYWOtB+4yOXKBx8RO6/NAn+cLpQusV
 0uT0dBGIrHVatj9GVscKVZ3dOiFzv1IyDDe4e5sfRf/9Gl647qKXEFfJV+KhTAEdOl5N4Ysw
 OEAvs8K6lXl1kFwaovf0nlZpzaWM3gNc6Q7rZVEUoXlvQoc1Q0Qa5LrDCKrsoqEbM9BMxR0L
 2bM1rbCnblV2mHLb2E3SSrWxeNYiJkD0PyQIITu+7hddhv5av4LMNl59CRxQxtVwxhD3vg1P
 GV3X6GwyWNi4B8w7PWvnUj1c+2COPFd0kjw0EcS0mDGT0SlUmHXamswJY5hOazfH310JlBmE
 XLx9IoheTLrZ93qmCYtWUNor/H5C9p86mUuXSxh89utR/EHXNYuvkNiiafkZfcq7QPdSXArf
 dVXwds=
IronPort-HdrOrdr: A9a23:y/SadaHBblF4QWygpLqE7MeALOsnbusQ8zAXPiFKOGVomq7xra
 +TdZsguyMc5AxxZJhko6HkBEDiewK7yXcW2/h0AV7KZmCP0wbFEGgh1/qE/9SKIVydygcy78
 ddmndFYuHYB1ISt7eY3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24660966"
X-MGA-submission: =?us-ascii?q?MDHhFk0Yp+apwKBVKsmyIGuHBrzu+BMTPai/Ua?=
 =?us-ascii?q?8GOWdUAq3Kwp5OupJiVYQMXNKKnhkvmWV6LrEBNFXNu5XThJY/MwAnps?=
 =?us-ascii?q?Vby4dfgx72dobPh1XWMTJoGWeoB3BUyOlggu6XhiI6XbrnYEdRVmpac7?=
 =?us-ascii?q?Wtx6RgV3IcG21uvYQWujUnwg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:08:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 42EE14A;
	Sun,  6 Mar 2022 16:08:06 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id D8EjHjJ77BPK; Sun,  6 Mar 2022 16:08:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 32B7339;
	Sun,  6 Mar 2022 16:08:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 32B7339
Date: Sun, 6 Mar 2022 16:08:03 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
Message-ID: <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-484760321-1646611374=:1906"
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 173
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/70ad3def-a4f-14b4-cb70-acfe4a516d9b%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-484760321-1646611374=:1906
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 6 Mar 2022, Markus Elfring wrote:

> Hello,
> 
> I have taken another look at the following code.
> https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6b3/standard.iso#L556
> 
> “…
> //
> ---------------------------------------------------------------------------
> // Pointer/Field isomorphisms
> //
> ---------------------------------------------------------------------------
> 
> Expression
> @ ptr_to_array @
> expression E1, E2; // was pure, not sure why that's needed, not good for
> rule27
> identifier fld;
> @@
> 
> E1->fld => E1[E2].fld
> …”
> 
> 
> I would interpret such a specification in the way that this SmPL code 
> transformation can be valid only if the expression “E2” will be 
> represented by something that will be resolved to a zero value. How do 
> you think about such an implementation detail?

Seems reasonable iif E2 == 0. Is E2==0 enforced somehow? What is rule27?

Here are some other equivalent transforms I can think of for E1->fld where 
E2 == 0. Also + could be - when E2==0:

E1->fld = ((&E1)+E2)->fld
E1->fld = (&E1[E2])->fld
E1->fld = (*(E1+E2)).fld
E1->fld = (E1+E2)->fld
E1->fld = (E1+=E2)->fld
E1->fld = (E1++)->fld  // but not ++E1




--
Eric Wheeler


> 
> Regards,
> Markus
> 
> 
> 
--8323328-484760321-1646611374=:1906--
