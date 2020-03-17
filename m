Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DFC18E5B
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E2D20714
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hmItB0pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E2D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02H9YDbQ014150;
	Tue, 17 Mar 2020 10:34:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DDEB97808;
	Tue, 17 Mar 2020 10:34:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03A573B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 10:34:12 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02H9YBRu012643
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 10:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584437649;
 bh=AMliciT26JjpRB6iMn1p7S/FrjEY/q1jJDhRIdI2LAk=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=hmItB0pi7yNHkblUCpJZC1dta3fEsmzr3KsScy0Qpl+eOZLSDFpz+FI69r2gYV+s5
 ++HxCMacanySEKuImlOaYUEfuarjlKfiX1anhBFrUVNWFWs02dQnDCccs55MYmLBnd
 utk4xTsyH6Wz/X7vXPIkKD8q0HrJoxNUZde3u5Tw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.173.244]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZPc-1jUXvx1obc-00yiFw; Tue, 17
 Mar 2020 10:34:09 +0100
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
Message-ID: <537c752c-009b-1fa7-4bdd-c294790d453a@web.de>
Date: Tue, 17 Mar 2020 10:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:lbYKBJX17ulgsG9TcxK9ohFSXBZySetn8VVTtO6+d5FBey+JGnz
 i3JNujdn24o6N3uc3a07SCoqpl8CXBmIDDOuAZwl/8gYvgubEqE3bOz49gnLQJJVDD3wSow
 t9M+1yVp5dlBWAuXY5hkopsFG0NaM7z3iv4eyL1H+FTnFDG4LpUkqUB4GtulZ74Lwhehr1d
 aANmSCBwbdD644uAiZiJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9eX0pHIT340=:T1cCbdThEHVq6dKaLXKrrX
 GxWfcXcaMWVQMHXeM+sDwK1fY4uoP0A3AjFO/T8+r6eWUKgY8F1lVMakfv6ROkXaDFW2EVw5C
 hY3hIQXMIqdcLydSwUN80g67E9hE6ynEyQPt+ysuRFQjudKB4g+njAIl5Ay9BrLuwQcx9Hm/q
 gIIUZ02Kc9e61EisHqdaRI6fqWXxgy79GgIyCCPgHEFIlDj0R2W031TvvUgptrAhBRaydPjZ8
 evSZtyTV856iyLn51X62GHeTLO24DSKpDtVR0adVUaBKjBP4LIp4HCKy5utkJCqZAvCOKlvDW
 LVZd7HlFiPNrmgLLSS9RaVDaDDw9qHYrXunoCMXnwKtNKv5CZSF5mEQ7sdNaLMHnKSz94MeCG
 w2dTRduTJx6iMmm6pPAQQbbnhKnTWHdRUsB6ldpVReJfK4AifJR3w6StIcK17A5z/zKIAari8
 j9awuwPzPx/9rOM4xTjyrn86+Vp4gLl/x7KCUM/8uiJqVeW+v1/kADm5QbRdhHq7ri1V9uhaK
 iHK3EANb4AzdsZGqNP+ECDd0LRTV4d6xO/DWYjtbH3kWe5qTtTfodbACRTuxC2Lv9pp0DAsPF
 HDQOa9uXaZpAdoiukFHYIIRNKBlSxUOC+cR4MlTpJO6oDffZ0S+yoASXjRp0jIHpZUoFpCJPQ
 VMgRLos1gAnbrxXARjtDNOrJFI9vw09+YKaqa6KVXc1otw2DWGICOPdNwQYE5t9zCPc/uRTdi
 qjSibgmbpf3fjETgbn+ncywdcpqub0MUuwZt9n8CPUT/vVNe3swsS95TtyHlKFAG6H8Ogo05J
 ngWLpG9Zg3IFaJj7Uk2wlKwc1mXi0KZwFJdbL1+d7oXuTC6sav5EN+mUxAB6KjTASuEJDlnun
 rDJGxz/HMDuCJewtR/yTIMPRexJlsBP0QmqDhmktyNv6QiQrMjZLzJEFMC9ztxoQ/vEKjE0kH
 wAfJLGqykYY4zxph5PqWM33yXk7TIwr5QaFJHCTkp0tQGL5aOWI8UZGoxCDBElKXTUXQpAqfX
 6hvbx/pUZomRYHmhhkIabmztNx86nyaB3RqUBOpUKQilQTbOELG7ZyoBKvDF3ZGKrgx/VunhR
 wiQJTemseCkFAzFmZQr0aeGxq4rMIxIjjxf8sWH/GAJ1Y7HM4wdgvxn5tAsOe2lV0eoVF7Ouz
 VQWFl5QgPobzjx0+ZvLvLPORqDIWsuKZ8sIEyFVQ2VeQfUxTwX+WoV8goem5M7HD+V5UJWE/C
 OMrMupt0r2LOOHdFz
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 10:34:13 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 10:34:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [v2 05/26] parsing_cocci: visitor_ast: Add cases for
 ParenType/FunctionType
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

PiBDaGFuZ2VzIGluIHYyOgo+IOKApgo+IC0gQ2hhbmdlIHRoZSAidmlzaXRvcl9hc3QwIiBpbiBw
YXRjaCBzdWJqZWN0IHRvICJ2aXNpdG9yX2FzdCIKClRoYW5rcyBmb3Igc3VjaCBhIHNvZnR3YXJl
IHVwZGF0ZS4KCkkgc3VnZ2VzdCB0byByZWNvbnNpZGVyIHRoZSBwYXRjaCBncmFudWxhcml0eSBv
bmNlIG1vcmUuCldvdWxkIHlvdSBsaWtlIHRvIHJlZHVjZSB0aGUgcG9zc2liaWxpdGllcyBmb3Ig
Y29uZnVzaW9uIGFyb3VuZAp0aGUgcHJlc2VudGVkIHNvZnR3YXJlIHRyYW5zZm9ybWF0aW9uPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
