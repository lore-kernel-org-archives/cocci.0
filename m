Return-Path: <SRS0=j8Co=YT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F70CA9EBC
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 14:20:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC30206DD
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="N4CRGtop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC30206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QEJl7X014592;
	Sat, 26 Oct 2019 16:19:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D4F1977BB;
	Sat, 26 Oct 2019 16:19:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6378877B4
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 16:19:46 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QEJiV9001877;
 Sat, 26 Oct 2019 16:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572099566;
 bh=srr66fuIq94zP9+uuFu6k/4aMfNygzopgHJkTjdQzoQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=N4CRGtopkuu4/84BgvoprXZREYnteOt+x0MAocFG2RTWCQh6Yws55r/Bm18MA1Sz/
 7/2H8y9+KKk3/lb7ZOuyYJP9rO6f8WSqv6Tfx40EgaZNdL1TWtBgZLCSe13bsNORSZ
 qdAbsUNVCggKrngQvzfXywv1e5s3d4gY/PiguazA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.128.16]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dg1-1i60Vv2RID-00sLYv; Sat, 26
 Oct 2019 16:19:26 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
References: <1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn>
 <4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <781f1507-9002-3168-9efd-ef15f0966dc8@web.de>
Date: Sat, 26 Oct 2019 16:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:7YSPFAhQ//7CCYkRdbTZDkGrKOXWAR3lCNpVajN6VocY7NQWb0R
 CBuc2kgdHxn6uqGUMduhkBsaRefB/caSL/hyrdPj24KpOaf/OLPCn/WHDyAh3/U6q7NmYJZ
 GscsCHaF47BMcX0D2paXUKvgjJLomBES0Jybk8DF8q0KiFM+u8tk27lofSTH5WPx5pBGn+Q
 h4Hy5hJ8yHjOrzrChO2CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3OF4axgjLk=:8bD3I/uobr+D2SjzZ0lk6c
 uAyVLMb4nMN39oFYDEGB9oGhrHB7/1GMhCU/IBaHJPxGQGrjnSrKLZszWD1xWNmQSDQDPwRWG
 AHoyqyhXgBIwcgV7T2ev5PbAl8btWeoyxccOHAhR43Xsq99XuRBaYXZdRs2dYOlwcWqCWqbG1
 Lk9dqYZNEZRjwoeIa6nsAc5hOgEw7jGU5jM2FO8Ms3zEAmJo6q8a8awI7NO0dZTKsKs9Dwctx
 e1DVdQ5pIg0qi086LDMgqhD9EssxGQEVkQUG2HX/cV8i9c0eHYNNuwiyqB5azMXK3uv8d9GV+
 mfKvJABfr9TJXNBYtEt8aYlZfL9k7fXfkGGeMz3oa7vuSDOwcbDFNGr2WcyLMguNsUYIf+I1N
 5VUaEPquf/rocUzPfO4V6MX+K8/ac1WGhbZxG8nhMqLOsWYSDTJ0COrlEdTq1fH5YnwNRUNty
 IviwIjdttdT7hWr2O9dnPu0fs/ESnobRvWjdSleRYs3ylTSQHZtQRVp7+M8wqCCXIbP054mYc
 zMmTZqG6oL9i5QFDnBdIcbkTBKDFFJhXjPKJX0I8571XbcY5fLMhWCPkKyLf/tG1qn2T2QD12
 t/1uhZq1/2nULJUrb8U4JC18CpkJN5bb8EDIcG/6EnxOHXZ2ogWscq5p/As2aZyaYmu68DDBH
 XQnXqaRAcJpDVOAO5ImKS33nbwIAxAlYesixKVx4146+f+X+drtzM68xOIWeaPK5OC4WhP7me
 XofGX46w4O+W673wboJ3OfT1iB9Kp/32Yj4mS7r3Xgss4zQTYHP60YtmnbkX/yWdBO9VJ0UgG
 jMLguRyC7IvEOaBvfYHiSh14ZgVXPr4TxNLrRAYlwx/MtIb2GnMhb5TONhnyzmSL/QNCFOh/n
 DxG5CaheJie2mGJenBjo/ETV7HW9tN0D3f+kPFrTC+GE0rX2YgtVpDZzwlVRrvRndDYppJ5Px
 Y2dlpN+WCOL62uJbDEYys0m7LRMtUuyad2Wc7RpypIs9PCcm51TjIdo6Ex0w//0UYdPnX8cQi
 gdqRTG3kaiEf5qIF12F7Qwcujm0rKIhBE9Y0ZaBeRPfSBbinrzxW0g+I0UIVbz6CPMYherXWo
 s/fIGKCcZP9YSsH/eH6gnDmLONhJGOChXe+fj/mICS7gQfGd8GhBA5hIfKbUCMAUXsTqnUnKg
 qjX5DyetT77XacVQupvcxctcOyE6ZIdhNkPqhxFakJ+YDimOnSNfe6K7OpvN3/Z0LVEcRF3sr
 tla0BFb/VLEdBrEdB7FcLUrtlWMH8PfLlYIcfNX7JIlDkRSZTKyyB4CkYazU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 16:19:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 16:19:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [PATCH v4] coccicheck: Support search for SmPL scripts
 within selected directory hierarchy
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBXb3VsZCB5b3UgbGlrZSB0byB1cGRhdGUgdGhlIHByb3ZpZGVkIHNvZnR3YXJlIGRvY3VtZW50
YXRpb24gdG9nZXRoZXIgd2l0aAo+IHRoZSBzbWFsbCBleHRlbnNpb24gb2YgdGhpcyBiYXNoIHNj
cmlwdD8KPgo+IFVwZGF0ZSBjYW5kaWRhdGVzOgoKUGxlYXNlIHJlY29uc2lkZXIgYWxzbyB0aGUg
c2VjdGlvbiDigJxVc2luZyBDb2NjaW5lbGxlIHdpdGggYSBzaW5nbGUgc2VtYW50aWMgcGF0Y2ji
gJ06Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2NvY2NpbmVsbGUucnN0
P2lkPWY4NzdiZWU1ZWEwYjU2YzM5Y2QwYTI0M2UxMTNhNTc3YjVhNGVmOTIjbjE1MQoKUmVnYXJk
cywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
