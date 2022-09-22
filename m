Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31FAC6FA82
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X8tz3BGHpb59U1IAAFY8e7K8NVjwfFWvr6PhrTI5DPA=;
  b=L7+BsPKO/1zA1lFlL+/Ekf6elny+EPSMoRwOGT5uwl/AFH7Jy3jNp8be
   +seSwGO6zznMnCO2jt9Q5L2IDoQy/u4Yqsmn0rTqUfbJcDE9MWnbpqkhS
   pfxK31QdYlCyKChWkKJQdMsSQoAJq85UIgakdyQDEeXZmAMlD+nU9ex3Y
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="54103728"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 19:20:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98825E0130; Thu, 22 Sep 2022 19:20:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 81FBBE0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 19:20:14 +0200 (CEST)
IronPort-SDR: 632c994d_TtyjfbmgOeL6aq9KGwBsR9vM41fZP7sCKZkRWTEyAm5fh4W
 XuGA2P4KqxbrqHYMH15u12R4202YoOXYf0kZTrg==
X-IPAS-Result: =?us-ascii?q?A0BBAABlmCxjhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIjgQFWLgQLRYROjm+Bdy4DhCaOPIovgXwLAQMBDTkGAQIEAQGFB?=
 =?us-ascii?q?QKEbAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBA?=
 =?us-ascii?q?RkJFwcOEAUihWgNgjUpAYNkAQICASMdAQERJgEECwsaAh8HAgJXBgEMBgIBA?=
 =?us-ascii?q?YJ5AYJsAQMNIwcMq3+BMoEBgggBAQaBQAEDAgwCQ4I3HywiUoFcAwaBESwBj?=
 =?us-ascii?q?ACEKCcQgVVEgTyDAz6CYgOFNYJmlH6EHyYEDgMZKx1BAgELQjQDFQMUAwUkB?=
 =?us-ascii?q?wMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvA?=
 =?us-ascii?q?h4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFMicQCSEcCgQaDQUGEwMgb?=
 =?us-ascii?q?wUKOg8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnB?=
 =?us-ascii?q?QMDBCgsAwkhHwcoJjwHWDoBBAMDECI9BgMJAwIkWnUCNxMVBQMNGSYIBSMXH?=
 =?us-ascii?q?QQIPAIFBlcTAgoSA5hUg0oCVD1OkxInj3CfDDQHgheBRIFJDIlnlGcGEy6WZ?=
 =?us-ascii?q?w4GkgmXCiCNHJUDhSqBaAEygVszGiSDNk4DGQ+OIBkeg26BC4NWhUw/NAI5A?=
 =?us-ascii?q?gYLAQEDCYVHAQGFGQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ClRMTagFTRct9v7HrtdRJiRgX161RBQKZh0ujC45NGQN5FlHY01je
 htvCmyCM/iDN2KmL9x/aty+8ElSu5PQyN9iSgM+/ywyEyJjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYpdDNPg06/gEk35q6q6WlC5gdWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVPKCSDXjCCd86HJWzj0/NhlNlkJB6g7o999OFwV8
 L9HEAlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMube03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GlL2EE9A7P+sLb5UD96RdB1p3fE+DaY4ylWvwKgxjFj
 0z/qjGR7hYybYHDl2PcrBpAnNTnmSrkUYYWPK+58/RwiRuSwHYSAVsYTzOTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDczXmdxi/vWLCoRMWHdZdewEn1O2T4unM3CuSPHA7dBtiMeUsjfJtQH917
 mbcyrsFGgdTmLGSTHuc8JKdojWzJTUZIAc+icksElFtDz7L/9tbs/7fcjpwOPLt0YaoSFkc1
 xjP83Nv1u1P5SIe//jjpTj6bySQSo8lp+LfziPaQSqU6Rl6DGJOT9XwsQCAhRqsBKCUURGwu
 2IH8/VyAcgLCoyR0jOASqMBEdlFBspp0hWM3jaD/LF4plxBHkJPm6gOuVmSw283a645lcfBO
 hO7hO+ozMY70IGWRaF2eZmtLM8h0LLtE9/oPtiNMIQVPcgsLFTYo342DaJ144wLuBd8+U3YE
 cjKGftA8V5GU8yLMRLrG7ZDiuVDKt4WnDOMGsmTI+ubPUq2PSPJF+5cbjNin8hgovrMoQPJ/
 sxZOtfCwho3bQENSnm/zGLnFnhTdSJTLcmu9aR/L7ffSiI7Rj1JI6KPkNsJJdY594wLzb2g1
 i/mBSdlJK/X3iCvxfOiMSw4N9sCnP9X8RoGAMDbFQ/whid7Pt/2vPt3mlleVeBPydGPBMVcF
 5EtE/hsyNwVItge02RCNcvOv8Z5eQ61hAmDGSOgbXJtN9RjXgHFsJusNAfm6CBEXGL9uNocs
 o+Q8FrRYaMCYAB+U+fQSvaklG2qsVYnxeldYkrvI/toQnvKzrREESLKo8ESH9AtMjTGnzuT6
 BaXC0wXpM7LuI4Ez+PKjqGl8aasSvVyLnNHEzPl7JKzDy37/3Wi86BEQu2nbTDQb0Kq2aSAN
 MF+7eDwD+0Dp3lO67FDKrdMybkswvfevJpI511AMFSSSHrzEZJmAH2N/fcXh5133rUD5DeHA
 BOeyOdVKZCiGZ3DEmdIACEHc+7a9/UfugeK3MQPOE+guRNGpuuWY35zYSuJpjdWdoZuEYUfx
 uwkhs4axiq/hjcuMfeElipkzHuNHFNRT5QYsowmP6GzhjoJ0l1iZbnuOh3y6ryLaPRONRAkG
 S/Lpazgg78H+FHOXUBuHlfw3M1cp680hjZ08HE4KW+koOH13s0M4EUJ8BAcbBhk8RFc4uciZ
 klpLxJUIIuNzRdJhe9CfTueJCBcNjKk+2ja6VgApEvGRWaGC03PK2wcP76W3UY7qmhzQBlSz
 Iu6+k3EDwn4Wd7X5TQjf3Jlp9jIb81DxieblO+JR826ToQHOxz7iaqQVE80ghrAA/JponbYp
 ONvrd1CWYeiOQE++6QEWpSnj5IOQxW5JUtHc/Fr3IUNOUr+IDiS+zy/G3qdS/N3Bc7h0BGHU
 pR1B8d1SR6B+j6ErWkbCY4yMrZEpqMVy+RYSIz7B1wtkuW5nmJyvYPy5xrOojYhY+9TnPYXL
 qLTcDO/EVKsu0ZEpl+Vku56PjuXXNpVQiz9w+G/z8sRHb0hruxHUB8/w5m0jVqvISpl+BOY5
 j3CQ6rsy81j1oVesI/+GYpTBwiPCI3SVcbZ1CuRothxfdf0HsOWjDwsq37jJBZzEYYKftZKy
 YS2r9/82X3asIYMU2z2n4eLE49L756QWNV7H93WLn4Auwe/Q+7pvgU+/l6nJaxzkN9y4tetQ
 y26YpCScf8XQ9Js+21HWRNBEhoyC7XFUYm4nHmT98+zMxk61RDLCPiF9nWzNGFSSXIuCq3EU
 wTxv66j28BcoIFyHyQ7PvBBAaEpEG+7DOFiP5f0uCKDB2alvkKat/Gw3VA84DXMET+fHNy8/
 ZvBQQPkeQ+vvL3TiutUqJF2ogZdGUMVbTPcpa7B04UeZ/GG4G86wSA1NJIbFtdLnya02JyQi
 PQhqoc9IX2VYNiGWUyUDBffssO3GeEEfNv0TtDs113BcD+4XetsH5M4nhqNIB5Klv/L0+ytb
 90TkpE10t5d3bkxLdsuCjeHbSuLCx8UKr/kOawwriAqPysjPA==
IronPort-HdrOrdr: A9a23:eMGd36xq7DbXf7mZFPWPKrPwCL1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOrIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="24444427"
X-MGA-submission: =?us-ascii?q?MDGgiOvCmVd9lLnZIK5kKaJJLh7g2TVdPgDXTq?=
 =?us-ascii?q?YLKCWhJnrvvfxs2IMXOuNrDK8AAhz0ALXu3bP5T9bJhEfGPta8OftAPR?=
 =?us-ascii?q?T/aUjn2V+eMWKQlAEfRGKRifFkLxqC93wHehaKQ7YDldBsm1SCB/nWDd?=
 =?us-ascii?q?8uFglDtKiVOUvVew4O5h1npQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:20:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663867203; bh=g6MuCSgkd/cEtTcI1/zv1cSOQxBaMaICYJro5DyV5AU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Ah+Sg/JYV0DqSk6zGMo52JhFG/P1UUVqcU9UMeW2z4OBQ6nRKBQJaFwvA0eIo9LwC
	 bnTndHOdxSjgdTQuYdWIPfgBWKrASW/IZpkP7Lz8NbK7ieIg3hY0smUEclCKOt7UAr
	 S2PkuMqy1U7YAlIA37ldHv1PWdHu2jh6HMy7lGbP5C1J3RGgAItVqKkJLqDvPVY6Iq
	 RXe81viaq0Fsx8RYSfOzZgB05QwkHIldaFEVdjn7CPDqVXAvYE5l/sOGTdtv7dpos2
	 mqv1jOdITVm6nyqr64SlU9sZKDDcuwegWC4MbXy1X3aieF+nwYJnlAWgEdr8R3DI5I
	 e0fjkLZRGX+rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1pDTeC142N-00gXNy; Thu, 22
 Sep 2022 19:20:03 +0200
Message-ID: <dc0d2493-9ccf-dabc-edeb-8e2838c67f5c@web.de>
Date: Thu, 22 Sep 2022 19:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220922115535.44132-1-yuancan@huawei.com>
Content-Language: en-GB
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220922115535.44132-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Pe2/AGQPBbb6QmzXSXBZqp+VkwGIEhVvvcG2Z0yNbmV45MXTLYN
 EdRblol3c80fq2pwBwy7XIOWdRRQ5Gk+Pus+cMhUcsv/YfEFmoOzJaTtctdpoKJKRyuSRP6
 oqXLnEQEWkWEPBAeexvEIscLHAdU3ICklMY4kvHF0LN5+lNxyAB/b9Wd29UiRCBGqTi6Eu0
 brT7Ej1QRCNjSnP6ZB4qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bTddvKxKgRk=:7vYIqnur54mQKVjvelxM1B
 ysAM5hrDkonGoA3o/VBM0RJrtKBZq6aoFWHPYpKuiPaHkwaSDzYHmddEbwUX4iPGxXjykMINA
 kqo+Klkez1zaCEhPVg2Z5/FtxlrkKONf2Uth5mpuBNnx9kSlqWti/PeRRMmFHGrQucCXvTTE6
 AFBfoNiNEmqALSQ0PfbBDAHcCf+KAIWs+OfXx0AwWK8bR23iMxNR1gJ6lk4H+KBCu/057YjSb
 59g+7r3JFHUW4xGGM86aLJ0cCP0Rsp3rxI6VqDCQsDdvZ/OOKJ7lwT4hgQ1e55l2yN7qSHUkg
 OpdFXnGWFTy3cbzy4zxtlGcKUunBJdA9SoknbGQKfXx7jDSWcxz+xPCKLYuGGPsPlTVjCflyY
 +tjKsj87ABXNb/Tq/63+rkU+mE6xkpkjJKHRg5gn5orJBTZvLhfMM7J+0nUja9RTG3zF+08dY
 Mh9zrNCQTyAwL4FdnN6rxizSbOasjBw/RiCI5reBtnrH5tjSSaJZc8HOvCA98bjT5ke/SAz06
 fV5F6+cWgFzVgwnhynDE8Vam8FevFmu6zbDzao4PmeXrdfHZ138JtCrBMmUC9Rbd2brIH5/kn
 stuSYVLWq1R8Mg/0VrBJCBqRdl/f3p6CnvJ4fETQh3rOkCcWm6EUSZim6ib9kApdhkv7lfeiH
 VMc/zccETJYjSC34foew3P7rOxxSgTtYhF5fHOuoqbINzVMVPLvdNlu2h1v0MqFtLppQ7QeJp
 Ur99intaJL58KU6AP7JLaYYkUlZY2pMcE8RutstvnR2CM65YfjGV8V9IqHgVZwDuk0lStIBKz
 evCIx5p31qBEbqNKtOk2SivGOK56sapE6w7P2YrsJB0kEdYacnm8tmt3SVZUUydhq2Tl1L8Gp
 jcQofkY/nua4qHd8laarEbqjzjR5FW36APti8w4aGUQy5W6k6OQFvUbv7HFLWhN2q/ovg7KXD
 IJByBry5aYSIABDlQGTxFMxBPR4Xg7ilNW7Lp0MwdVHq4xgz4sbBzMwYF12guI5CRDkpoE9uA
 coxfQvUr27lEhRoqBrE8uY2e6WkTbHs1JzwSI9F25eqKwAwzDUZDnUWCpAQ0XCT1o/E5DY07R
 MklGpDmuxjSrnQGTedyw/3WyriiDrvo+Dgmxq2IsPvl4oKGwW0LNKHbhuBaJW8+UrCR//ygXs
 5xM4qB7rd1nCUNfVmjrR0FTokE
Subject: Re: [cocci] [PATCH v3 0/2] coccinelle: Introduce cocci script to
 detect missing mutext and spin lock initialization
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 573
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/dc0d2493-9ccf-dabc-edeb-8e2838c67f5c%40web.de>

> This series introduce two scripts to help detect the use of mutext or spin
> locks without initialization.


I suggest to avoid a few typos in this wording.



> Yuan Can (2):
>   coccinelle: locks: add missing_mutex_init.cocci script
>   coccinelle: locks: add missing_spin_lock_init.cocci script

I would appreciate answers to my remaining open questions.
https://lore.kernel.org/cocci/fb101290-3ec7-9170-9fec-43e1b5f54c52@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-09/msg00022.html

Would anybody get into the development mood to generalise and extend the source code
search pattern besides proposed adjustments for the handling of two APIs?
https://cwe.mitre.org/data/definitions/909.html

How many data structures would need further initialisations after memory areas
were allocated?

Regards,
Markus

