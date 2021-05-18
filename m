Return-Path: <SRS0=qQWm=KN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4099C43460
	for <cocci@archiver.kernel.org>; Tue, 18 May 2021 09:05:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF096108D
	for <cocci@archiver.kernel.org>; Tue, 18 May 2021 09:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF096108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14I95frp015591;
	Tue, 18 May 2021 11:05:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F81377DD;
	Tue, 18 May 2021 11:05:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 63BDF3E16
 for <cocci@systeme.lip6.fr>; Tue, 18 May 2021 11:05:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14I95bOt024896
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 18 May 2021 11:05:38 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3209761209;
 Tue, 18 May 2021 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621328736;
 bh=IM5NhaVNLdnTl/c0Hva53kexF4GIAfDK3JsXGk38oVw=;
 h=From:To:Cc:Subject:Date:From;
 b=r8+FRGmS/9jbwmmJkTSz1W5UfNRn33f+MlK7+SjhrtxMF8e838smb/hXFr0PLLm9T
 qZtBtM8q1XSrW6RFsbqBjElPXbgaYEjNCy6uERcuGC6Rte3plj6RKidaDZkgCkFLkK
 phpJN4/IOzaBQAUl3DLVPuT3Q6y8xo8oTy8lHVwiWrdXDN/GUPAcOuCJjsCFUfUigd
 Iad681QinsSLa8AvsQ39wZMFYvJcy9HuUVhe24uaRUmenQC2zCUVr1Hvq2XeAf9VLY
 NVzSV+vBXAKREEWH3X1cX8UqnuS9U6ZUiDDg2xGtqRvUn6HwFB4aGC+nQGEU+lTHTG
 Cc1jIFU6fPOVQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1livfO-006zQ3-6E; Tue, 18 May 2021 11:05:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Date: Tue, 18 May 2021 11:05:26 +0200
Message-Id: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 May 2021 11:05:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 May 2021 11:05:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: fix troubles on non-English
	builds
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

V2hlbiBMQU5HIGlzIG5vdCBzZXQgdG8gRW5nbGlzaCwgdGhlIGxvZ2ljIHdoaWNoIGNoZWNrcyB0
aGUKbnVtYmVyIG9mIENQVXMgZmFpbCwgYXMgdGhlIG1lc3NhZ2VzIGNhbiBiZSBsb2NhbGl6ZWQs
IGFuZAp0aGUgbG9naWMgYXQ6CgogICAgVEhSRUFEU19QRVJfQ09SRT0kKGxzY3B1IHwgZ3JlcCAi
VGhyZWFkKHMpIHBlciBjb3JlOiAiIHwgdHIgLWNkICJbOmRpZ2l0Ol0iKQoKd2lsbCBub3QgZ2V0
IHRoZSBudW1iZXIgb2YgdGhyZWFkcyBwZXIgY29yZS4KClRoaXMgY2F1c2VzIHRoZSBzY3JpcHQg
dG8gbm90IHJ1biBwcm9wZXJseSwgYXMgaXQgd2lsbCBwcm9kdWNlCmEgd2FybmluZzoKCgkkIG1h
a2UgY29jY2ljaGVjayBDT0NDST0kUFdEL3NjcmlwdHMvY29jY2luZWxsZS9taXNjL2FkZF9uYW1l
c3BhY2UuY29jY2kgTU9ERT1yZXBvcnQgZHJpdmVycy9tZWRpYS8KCS4vc2NyaXB0cy9jb2NjaWNo
ZWNrOiBsaW5oYSA5MzogWzogbsO6bWVybyBleGNlc3Npdm8gZGUgYXJndW1lbnRvcwoKRml4IGl0
IGJ5IGZvcmNpbmcgTEFORz1DIHdoZW4gY2FsbGluZyBsc2NwdS4KClNpZ25lZC1vZmYtYnk6IE1h
dXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4KLS0tCiBzY3Jp
cHRzL2NvY2NpY2hlY2sgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpY2hlY2sgYi9zY3JpcHRzL2Nv
Y2NpY2hlY2sKaW5kZXggNjVmZWU2M2FlYWRiLi5jYWJhMGJmZjZkYTcgMTAwNzU1Ci0tLSBhL3Nj
cmlwdHMvY29jY2ljaGVjaworKysgYi9zY3JpcHRzL2NvY2NpY2hlY2sKQEAgLTg3LDcgKzg3LDcg
QEAgZWxzZQogICAgIGZpCiAKICAgICAjIFVzZSBvbmx5IG9uZSB0aHJlYWQgcGVyIGNvcmUgYnkg
ZGVmYXVsdCBpZiBoeXBlcnRocmVhZGluZyBpcyBlbmFibGVkCi0gICAgVEhSRUFEU19QRVJfQ09S
RT0kKGxzY3B1IHwgZ3JlcCAiVGhyZWFkKHMpIHBlciBjb3JlOiAiIHwgdHIgLWNkICJbOmRpZ2l0
Ol0iKQorICAgIFRIUkVBRFNfUEVSX0NPUkU9JChMQU5HPUMgbHNjcHUgfCBncmVwICJUaHJlYWQo
cykgcGVyIGNvcmU6ICIgfCB0ciAtY2QgIls6ZGlnaXQ6XSIpCiAgICAgaWYgWyAteiAiJEoiIF07
IHRoZW4KICAgICAgICAgTlBST0M9JChnZXRjb25mIF9OUFJPQ0VTU09SU19PTkxOKQogCWlmIFsg
JFRIUkVBRFNfUEVSX0NPUkUgLWd0IDEgLWEgJE5QUk9DIC1ndCA0IF0gOyB0aGVuCi0tIAoyLjMx
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
