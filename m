Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6C8C433F5
	for <cocci@archiver.kernel.org>; Sat, 26 Mar 2022 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TZYO3DUitcHRWW4YFaZsNMj5vv/Dl/OGkh6Ax8nabD4=;
  b=pCLYpnIzQYfDniTuGv/cr/tGrSD3+xWuDWM4L3rBFRXk61TByQ5b7P2Z
   KNVVGLtTjAu+1208mvHkQWqF550hP8T7QOBpyJvA/n7BKeH/W7HcW3IGD
   ije2IuETMzNASWo1i3BEOJQXxtwdJlg3yBtMNs8FNWXp75kdTkbbOwbEZ
   k=;
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
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28236385"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2022 08:09:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ECE3BE4372; Sat, 26 Mar 2022 08:09:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 301C7E436E
	for <cocci@sympa.inria.fr>; Sat, 26 Mar 2022 08:09:30 +0100 (CET)
IronPort-SDR: ALTDLor3BSCsSElKnBC0uzq5e2wlx/6zWXGqn/jnlhsemERBbdhj/nWqE1A8u0W5/uUnuU4Xyt
 cPQBokUm+0MG/tslDFddVrWbagF1dxfyZxfrY7ULGuOfwtX4+T/TSIwv5NReUya7oIsEv+RqXg
 jvQ+kEVCAAYvg5YxOL+tMOjbzdDhXiwZHFb8oezmmTRZNjzFuCteZMkEYBdP4mW0Wt3Ua1Eetp
 sw5R5xuhKzjKR/1qSaUpMZmFQrFwoC5qP8PZEYVYIZ+wqVxzYenmMAKvX0UFvjiwEh5Cn1vYEf
 RybEsML0e0L/hgPnTPQlVo2J
X-IPAS-Result: =?us-ascii?q?A0AABgD8uj5ihwMP49RaHQEBAQEJARIBBQUBQIFaAoImf?=
 =?us-ascii?q?lcrBAtEhFSOc4Iokj2KKIF7CwEDAQ0SAQEnBQECBAEBghKCdQKETgIdBwEEN?=
 =?us-ascii?q?wMNAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBg0IA?=
 =?us-ascii?q?QGDAAGCZAEDDSULr1mBMYEBgggBAQaBPwETQYI0HywiUoFbAwaBECwBjU96J?=
 =?us-ascii?q?xCBVUSBPIJTMD6CYwEBAoFegxqCZZk7SRDCdDQHghKBOoFBDIlClE8GFC6DY?=
 =?us-ascii?q?pJhDgaRb5ZcjRaZboILAoFpMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDW?=
 =?us-ascii?q?TOBC4khQDQCCS0CBgEKAQEDCYVHAQGMFwEB?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDQI
IronPort-Data: A9a23:GBBZb6jIjNVlGwzjtWvD0j2cX161ChYKZh0ujC45NGQN5FlHY01je
 htvXTvTbv6PMGCnLt8lOtzk9RgF7MSBzodlSwFt/HxgFnljpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JeBYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplk765TR4yEKH2k8MBQjdkFA5ePPRa0eqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bY7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzY4Ggm1h2Jwm8fD2X
 /Q/SyVldEn5SBBTa0onM5ABw9+5vyyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjajkePcOWzT6t4HOpjPXG2yL9QoMbUrOinsOGm3WWwXEPTgIbXx23rJFVl3JSRfp5C
 UUQ4zEAoZI501C6YOX6cD25+WKt60t0t8VrL8U27wSEy6zx6gmfB3QZQjMpVOHKpPPaVhR3j
 wXYzoiB6ShH4eHEECr1GqK892vqURX5O1PucgcoYGM4DzTLpYYuklTQQ9wlHKPdYjzJ9dPYk
 23iQMsW3ut7YSs3O0OTowqvb9WE+MGhc+LNzl+LNl9JFysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpbCvLlTUcnRyXLRH43h+Y1FAd7aYVUwZnYwTvEcG8iFoCLLkX14vW0vehwzWir6UWW0O
 ROK0e+u2HOjFCL3MfEuOtzZ5zUClOa5XdXjSv3OaNdSKpF+HDJrDwk+DXN8K1vFyRB2+YlmY
 cnzWZ/1UR4yVPo7pBLrGbZ1+eJ6nkgWmDKILbimnkTP+eTEOBa9F+xfWHPQNb9R0U9xiF6Im
 zqpH5DWkEo3vSyXSnW/zLP/2nhXdCBiXsqn8pY/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 n3iCEJe1nTlgnjLdVeDZnx5NuHwUJw5oX9iZX4gOlOh2n4CZ4ez7f5DJsVtIuR9rLRunaxuU
 v0IW8ScGfARGD7JzDQqa8WvpoJVchn21xmFODCoYWRkcpM5H17J99bocxHB7i4LCibr58Iyr
 6f+hBzWS9wPSl06XsrRbfuuyXK3vGQcwb4jARGXf4MLIEi1qdpkMS38iPMzMvogExSby2vIz
 RuSDDcZufLJ/d0//u7JsqbY/Y2nJO1zQxhBFG7B4LfqbiTX8zbxwYJEV+rULznRWHmtofenY
 vhJie7xOrsLkQ8S4YZ7Fr9qy4M45sfu/uMLkF47QS+TN1n7WKl9JnSm3NVUsvMfzLFuuTywB
 hCF9O5cNOjbI8jiClMQeFEoY7jRz/0SgTWOv/05LF+jvX1y+6ebF1pfNV+AhXUFfrdyNYokx
 8YnudIXslDu1EB1b4ze1i0EpX6RKnEgUrk8ss9ICoHcij0tlgNIb6vaB3Kk+5qIcdhNbhInL
 zL8aHAuXFiAKpcuskbfFEQhGcJYgokS/g9HxhkOKjxlXzYDauAfhHVsHfYfF2y5DSmrF8psN
 2ItO0AdyWCm4WJznMYaN4yzM1gpOfBak3AdD3MWmWefQ0TAuqkh6oEiEb7lwX31OF6wstSWE
 H90BYolvfvXkBnN4xYP
IronPort-HdrOrdr: A9a23:pXbbYa4M5LxrR+j3cwPXwOzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="9662964"
X-MGA-submission: =?us-ascii?q?MDEIinTyezD2jJytf41U1SYgVzV0vV1BLr7aHJ?=
 =?us-ascii?q?m3f0ehjxyISs/Zx9vAQqPoAzw1kG8SFSQbt02kgGadUfZms7WuHxxRvh?=
 =?us-ascii?q?7cQ6GlXdI7sTF6gQbevsOHjON1ssTwDm1zQ6MzYBYr8krQ2LLR8da5AA?=
 =?us-ascii?q?wffh2SiUp/f984jARtF3GlXw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 08:09:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648278568;
	bh=TZYO3DUitcHRWW4YFaZsNMj5vv/Dl/OGkh6Ax8nabD4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M/n+r9nUGJl/zGpWvd+Z3YERJ/gC+Jf9AcxS6gLfVnXxBim/4LCf2+yVtj61LZ1KB
	 5RCV1aUzUF/M9BJ8I0QgXz4lkrM9diEOTWIVn2gXOXAoRBWJ0LFWOjPBUA8Qj3fZIr
	 9npJd1p4E8UiqiAAWeGbNEWYoQ3f6+AQSLceNlZ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.183.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1nRetd1HzN-006kwQ; Sat, 26
 Mar 2022 08:09:28 +0100
Message-ID: <fc339654-ec79-419f-d42e-7b6fbce6968d@web.de>
Date: Sat, 26 Mar 2022 08:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Beb03keS6zV2fkYuAusIaUsLlvM9wscbQdxmO3j+kdbGPsTUZI
 fzUQ6tarYvnqXfiysmAX3XdQXsjn9P7KRkC/hSk/Sph3QgVw5RaPCaUciPc/1rbXLCewfoO
 IEFDUaHpmoGv/hAXTy3cY5AuCSekt/a2y5A7cYdMg7VGOjMxfAmD/tipNm3IM7ZljxyRAln
 54N6rZPlHGVPVChXMLKvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:po+y3iG1n9c=:9m/CXaPpkZVtYW6kqLhT1O
 ubnzXu44R2H6Fjued5elfP8V1KhGiX7TzDaI86ErrwTD6T2Ue3HfOb9p5SdHcYuYTF9rVzBP0
 Kbo8FdIyDFMHpGPJfHnZbdcSW+jeJD4AxXf/03VKzYl/4PDfSsCwEB+GD5Ul06vfZUDwODoci
 sng10SU06WR/QWbaCbUl3hZQc3GMxRR06ELDe2rinKjr+mwqFbOEzkJHOxNgQlwgiz0P7ZTt0
 xkfasG1JVsXE7GqQpKO2EMCGwTK36nWtxfIx9p2EfsEJvZWqKa3i/HhML/J0wRaicqVjKRAlY
 XkFOFzpn94C9psdSjMV7xlGpk7U+dIwmljE7S6UWzE3boqyiFtthDFF6NJFTvqNlbfijk+Nrn
 2ogqZPgYaetUHgxXZwkyAyAO+MZ89BwOMbawRaqIsrxQBgYJSNe6O1p9B24htNQwI6EcwepJ/
 O79O6n2gOR6gT5IoICZzwZj6pIaztJEo2n9+p7idEgSWHojHe2/qWQCQWXxnL0s2SSjC/qylg
 fr6L0AwXLrCFFP24g24rS5brL3nLV+IneYGxW7kMiXyFTIS3aoLNOXa/eyzoIHSlRRBHtxqSk
 2YnkapXlfbRfB/GMqmENAb7/d/DTeNmNJNeWmdl32z7Hvegqo4Hu6ie1LMt58Mwp70Zmqednn
 Ej4QtXd7/nOoR1/8unEQhZbnMueHsHZDG8ymw5Z4MrGkKTqL3E7RtdSdXmNjVoFQAWH1jcVBM
 TlM0+STdBfoDCME9V0EV99d86WAyFMyoVv3YwEHRu8DIE2+P4TPn8xL+Kc3gSuqfK5XBEBup+
 sGf4RQiE3ZxRfNg2OEme0SOzVhPoTTcFskJimi8qpeKU9r+4rLv5oNZk/zq9LZ84m4MqJkxRd
 g/dyWYFkbFIrS2C3n4XjBHsG0B/oGXEwjexVEzzQdDlguR1ZFlpZo4H26qIC4sJROwZXONTgc
 YoFkypNOs3G7pI/sBsgg9B2Wo44Spj3WFAlSxMrQoGBff3O1Cy49cH299lmmsCVQw669YY6/+
 gm1WjZG1nWYyeAghi2nXn+XbsHbMlhzpGGizKHk8nwEGd4Is6fRf43H66xUQCKr8hlgR+kjah
 Bzq5ERmzbk79II=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 292
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/fc339654-ec79-419f-d42e-7b6fbce6968d%40web.de>


> constant char[] x; ?


I suggest to improve the software documentation for the safe application

of such metavariable variants.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/248a2742e76ceab620d67=
967a537fc5cb9282405/docs/manual/cocci_syntax.tex#L236
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L236

How good does the data type =E2=80=9Cchar[]=E2=80=9D (an array or pointer?=
) fit to the hint =E2=80=9Cctype=E2=80=9D
in the SmPL manual?

Regards,
Markus
