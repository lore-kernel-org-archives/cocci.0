Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD52C433EF
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VHE2yGKrQW7AxIt2yJ0CxUQBN/1rcULVQT+yzBuyOuU=;
  b=Mar/ttA9UusuimorXQDAzNPIB8b//2swOIVLh05x/dTRcYDb5jaeQpLd
   9E3u+xw8v4cZvL6gIl3vQ+qeWYJlvpYe43AuK7AqcACBXetUB0jaUwPOv
   jR7rIaqXm0k2l2CEOBvCBW98P6vVILtFvuhvlqgB7vg2EYxfQ1eltXpn+
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,212,1647298800"; 
   d="scan'208,217";a="35431655"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 21:23:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2BD03E0154; Mon,  9 May 2022 21:23:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 94EB7E009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 21:23:34 +0200 (CEST)
IronPort-SDR: 9AfxN8JlfaQ3qWrMR8eU/GoN8akA6J01itW8jnpj3FYEr6lHMJsaY/hO/6zbsybE9tMRil5i20
 CgZZNwvxcvQNm7Fh/ntvH23rCKDFLJyR5yROyIy95GxG1OIYtlAL3QoObn3rj7RxHsA7GLAefU
 LgDu3tvlv+F36lOON5sxtWRah0Q0dxoN8QAFyQOvnf3/AbQqRUDXHcsnLQk+AKE1H9mOV+/gUr
 vCZWmtotb0PYvHp0sCK64J0+rm5mMUKAowV+daIhS5Al4vNV0WlsJy+RsCyIRNc2lraXqHDqQG
 /uFx9fPAROTSqvKaBom/kh4/
X-IPAS-Result: =?us-ascii?q?A0CoAQDyaXlih07ASNlaHgEBCxIMhDN+VS0EC0OETo5mg?=
 =?us-ascii?q?iieXwsBAwENOwQBAgQBAYUCAoU9Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg?=
 =?us-ascii?q?2QBAgIBIx0BAREmAQQLC0ICAlcGDQgBAReCYgGCYgEDDSgLrGaBMYEBgggBA?=
 =?us-ascii?q?QaBPwEVQYI0HywiUoFcAwaBPIc6AYciJxCBVUSBPIMDPoJiAQEChTSCZZYqW?=
 =?us-ascii?q?aRNnVd8NAeCEYE7gUEMiUuUVQYTLYN1klUOBi+RRpZijSKZfIF4gX4zGiRPg?=
 =?us-ascii?q?mhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDWTOBC4kiPzQCCTACBgsBAQMJhUcBA?=
 =?us-ascii?q?YwmAQE?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23:uG/xB6uYyodPUt0z9qQq1wlh3OfnVAdYMUV32f8akzHdYApBsoF/q
 tZmKWGAOqnbYDCmeYwjbNi38UoFvpaAz4A3TAJlqH08Rn4RgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52LBVPyvX4
 Ymo+5CHaQf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnaCQcisVF533pPQEAiUJIng5A6RD/oaSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXq
 rpHcnZUP0rF2LLeLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwh2ps3ZkQQa+2i
 8wxdX1BakXQeyF1EEY3Ls9mkMyqq3qmfGgNwL6SjfNqvzaKlVIZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXOFz0hKA9W+wwPDCl2X3Ver+CYFU6NZWoGa/+kUjMyEGTAqH8MjgzXC3XtRmf
 hl8FjUVkYA+80miT9/YVhK+oWKZshN0Z+e8A9HW+ynQk/CFsl3x6nwsH2IQMYROWNoeH2Ryv
 mJlie8FEhRDndWopZ+187CJsXWtNCJTIWJqic44oekts4iLTGIb1EqnojNf/Eid0Ied9dbYn
 WrikcTGr+9P5fPnLo3ilbw9vxqip4LSUik+7RjNU2Su42tRPdD4PdT1sAiBvKcYdu51q2VtW
 lBby6ByC8hRXPmweNClHLll8EyBuqrUbmaG6bKRN8N6pm70k5JcQWygyGgjeBkwa5hslc7BO
 QGK8QJX+JJJOna2JaZ4C79d+Ox6pZUM4e/ND6iOBvIXOsYZXFbeoElGOBDMt0iwzhlEufxuY
 f+zLJf3ZV5HWPQP5GTtHY81j+R0rh3SMEuIGPgXOTz8jeHBDJNUIJ9ZWGazghcRsf3U/V2Jo
 4oOXyZIoj0GONDDjuDs2dZ7BTg3wbITXPgacuRbKbyOJBRIAmYkB6ODyL8tYdI3gKlf0OvFp
 ynvVkhdwVv5pHvGNQTTNiE9MuyyB84noCJpJzEoMHapx2MnP9Sl4pAfQJ1rL7Mpw+pukKxvR
 P4fdsTcWflCE2yV+zkUYZTngpZlcRCn2VCHMya/PmogcpQmSwGQoo3oeQ7m9S8vCCurtJJi8
 uP6iV6BGcIOHl0wAtzXZfSjy0KKkUIcwO8iDVHVJtRzeVn39NY4ISLGjsgxf5MGJyLFy2bIz
 A2RGxoZ+bLAroJpotnEgaeI89WgH+dkRxMIGm7G8fCpOCOc8mf6md1MV+OBfDb8UmLo+fz+N
 LsPkKymaKUKzARQro5xM7d31qZgtdHhkL9tyFg2Fnv8aVn2WKhrJWOL3JUUu6ARlKVVvxC6B
 hCG9tVAYOzbPcT4DBgOKQBjYunajaMYnTzb7PIUJkTm5XYrreTdDhgIZ0GB2H5HMb94EII52
 uN/6sQY3AyIjEZ4ONixiC0JpX+HKWYNUvl8u5wXaGMxZtHHFr2fjV3g5i7KDFWnbtJRLg81L
 zXSiKeqa3GwAKbdWyJbKJQP9bM1aVcyVNRi01IIYViE8jYAruFixwVfqFzbUSwMpiiqEItP1
 qxDKEB/Y6mDl9utaA6vQEj0czx86NalFoAdBrfHeKA1j6Vla4AVEFAABA==
IronPort-HdrOrdr: A9a23:Zb1BY6COtIO59hPlHemC55DYdb4zR+YMi2TDGXoBLiC9Afbo9f
 xG/c526faQsl0ssR4b9+xoVJPwJ080sKQFmLX5Xo3CYOCFggSVxehZhOOO/9SjIVybygc379
 YCT0ERMqyUMbE3t6bHCBLTKadZ/DBrytHSuQ/mpU0dNz2D4MxbhTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,212,1647298800"; 
   d="scan'208,217";a="35431641"
X-MGA-submission: =?us-ascii?q?MDGL1/pHUej34qqo354QXE8+9/Y/+St9tiFu6W?=
 =?us-ascii?q?qCkLIuFKZ/s8rb5joNZ4OCyJFiF9Jp8BQ5gjZ1LUJaBZwwgs5hrOB85E?=
 =?us-ascii?q?H9Z00gYhEghkCGeGGoZAINaLVsCtEkuPLGf+ZC5nrh6reqymmVJ+hQqQ?=
 =?us-ascii?q?c+hQDjZRTj+xGzCB479f3ZLA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 21:23:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652124204;
	bh=ntzmmjr36jEIEICFWTvSBOkqssuaz4mgVK23yi+7y1k=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=m70E8l1Lz6K8xsEsAfr/+OKnqKGzu9kV2HCoNycOqk2ZsxtPy1tJmjOnjbk609ZCa
	 SZkDAmwOBHHkfcbDFVZKJnrwcXfquzot/x4j1K4eDcjJ4PjdLaq0/Qz01Ti9vQsnS9
	 Pln3JNX6TueNg3BKVjsekuHKOpV8IQO5dI8ERdFY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.163.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1nUXep0kIt-00KhCp; Mon, 09
 May 2022 21:23:24 +0200
Content-Type: multipart/alternative;
 boundary="------------34O24L8beq27dpNtKqvlIh34"
Message-ID: <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
Date: Mon, 9 May 2022 21:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Alessandro Carminati <alessandro.carminati@gmail.com>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
X-Provags-ID: V03:K1:Hvb0z19L+lvFBBebywouNAqzZNRIqOQWhFBssQsOwiuOmNTFay5
 nw617WXUNCCX15FaUxdyeVbedN997QddrSGalabRmgQXHZ3sXC4mNvFAS08Oz221QgnZLt+
 Vk8TPVOXS3PJ1zml/f4u7w+wRjhWal6tLX6/KIKaTcZA/5iYykSO6VyMo6spArf69wVxjkM
 qBJWLRWVY8tjGUKnUuyWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/n9An5e7fg=:n7iUnfs67++k4sQw35Ax0X
 dCDuh4q6M7PYS3zfzJhbBxnvZ0DWhtfI+9eij7n4kS80QWNFOuvPh7csn4z0OxeTGJ+VtVGRl
 vHZyHLf63pxyAGbISrhT5diTBJZYGyGe9fJi3lqySmJub0w9dA19YIIkbshHGRhGCRvg3UGv3
 cL53VA/2pYYGnlmDe9a7Q9ExtFdc5XOjxlXXBGeA3SnOmrLisv17gIM+PX3wud3z51RozVQCV
 nj+TTe+tFr4UWhP7jspPcN2ZggWaLFOks9kYzb+OHsrW0obgh+qCyhnytbyB7qS+I0ndLDP7T
 qxtKMHTSjKrUjWBP8iEmrf9rOM6tWsLZtb/i6kfJE8Yx6YEbQFkwd1C1oO+Boph77FxZguoD2
 juPTGpHH2iubxP6m46BZiF53KtVnz9nQVtVacGYdbMi8wn3tLITj1IEcE0yu2m5KIkMQ8VLJU
 bsc6oMyjDm6hiXhKTbHjeHK/7QidIASAKU8jTe5bp8T5fWtS4dZ/fzgKmGl79Ww9jVCXWzEBH
 EEGOPJx/ZASUD7rjv+jyKpG7J+SWqKYzCDvVYfrrRTvGBxuX1+vO4BMluRwagkyPW9nCGloO6
 0Yl82R3NijDh2elGvxJK7hkLpQDKS2fmtSaybgvN6ecPNN2+WA8iRyaC16hYvZxWTtVs/wPYP
 sjOOT2xJ1lX4jlvqDmeSQorAXw7rC10Gr2pNL9Lk2HUIUVuzOqXLK3vX1LEGWBIX6Df8Gurl5
 OvC41UuDe8W1IolzSkzlDBFDlZGuCvwAJaECzkdqvSCy/+IIVXU+YLMSuO3Q7dAb0xdupQ4a9
 qpzNkLzQE0Aj2yDjf8U9NwSUvMuvwHLH+YfCZIGDvC5Q32Q88czaNCO4WtwxLSseDit+Ulin1
 dq6eW1v3+mWxjsQbSAQXFDTzHwynoJNsLBR/SEkZ5HrUMzs8+Vol6jiFUYAU3O0BQTwRxX/hJ
 RA2nO4zu3Qr4qXTgi8I/zsYP54XwZslg2J2X1v1xvJi0HN9tHGsZDbIW+Ljkk4RCTlcCwq0Xj
 27XZkN/oE4W7ua4UavVE8/hKwo5aywXqBu6dJbIRSl0m0/uim5DDo7Na2jP/EH+Zeqbscv/SY
 11W8RYe5x4BQR8=
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 370
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/6a926cad-e15a-5c04-1fc9-34d20bd18618%40web.de>

This is a multi-part message in MIME format.
--------------34O24L8beq27dpNtKqvlIh34
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> The solution you sent indeed does what I expected.


I doubt that it fits to your initial source code analysis desire.

Are your expectations still evolving (also for your data processing needs)?



> Would you mind add a short explanation of this statement:
> `position p : script:python(i) { p[0].current_element == i};`
> I probably have a simplified understanding of what a position is.

I imagine that known information sources can help further.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L410



> Maybe it is worth digging deeper and having a more concrete knowledge.


Probably, yes.



> Any read you want to suggest to me?


Related links for example:

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5
https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6b3/docs/Coccilib.3cocci#L5



Regards,
Markus

--------------34O24L8beq27dpNtKqvlIh34
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <blockquote type="cite"
cite="mid:CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div>The solution you sent indeed does what I expected.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I doubt that it fits to your initial source code analysis desire.</p>
    <p>Are your expectations still evolving (also for your data
      processing needs)?<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div>Would you mind add a short explanation of this
              statement:<br>
              `position p : script:python(i) { p[0].current_element ==
              i};`<br>
              I probably have a simplified understanding of what a
              position is.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I imagine that known information sources can help further.<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410">https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410</a><br>
<a class="moz-txt-link-freetext" href="https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L410">https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L410</a><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div> Maybe it is worth digging deeper and having a more
              concrete knowledge.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Probably, yes.</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div> Any read you want to suggest to me?</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Related links for example:</p>
    <p><a class="moz-txt-link-freetext" href="https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5">https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5</a><br>
<a class="moz-txt-link-freetext" href="https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6b3/docs/Coccilib.3cocci#L5">https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6b3/docs/Coccilib.3cocci#L5</a></p>
    <p><br>
      <br>
      Regards,<br>
      Markus<br>
    </p>
  </body>
</html>

--------------34O24L8beq27dpNtKqvlIh34--
