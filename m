Return-Path: <SRS0=VPYo=LZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,FAKE_REPLY_A1,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2587C11F64
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 14:23:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DDE61406
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 14:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DDE61406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=johannesthoma.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161EN55m016782;
	Thu, 1 Jul 2021 16:23:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5CE37610;
	Thu,  1 Jul 2021 16:23:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B3D824065
 for <cocci@systeme.lip6.fr>; Thu,  1 Jul 2021 16:23:04 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 161EN3UB015065
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 16:23:03 +0200 (CEST)
Received: from johannes-air.local ([62.99.137.214]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MowOm-1lRJoy0i4M-00qQAL; Thu, 01 Jul 2021 15:41:54 +0200
To: jason@zx2c4.com, cocci@systeme.lip6.fr
From: Johannes Thoma <johannes@johannesthoma.com>
Message-ID: <471a429f-76aa-44af-19d4-10f53992866d@johannesthoma.com>
Date: Thu, 1 Jul 2021 15:41:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:Q6T4rcw758IV7G2DhVzQUdml+Jt/nuhhQkCxZ3erye1/1Es1HMY
 B02hAfI6EYX9OgKiVtTeUgBJ52VH/PIDT1K+0t/Bi0itg02W3na5KenTxFtcIcxSBGMfneY
 2jL7lB3a6Qu7Ih+WDByyiKtCyDcLG95sddqniY0VSurw4RntRlSP/iAO/tNycxJfrcVAG5Q
 cWaa5tFhuQPn2SyoNGgfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2HQz/WfJQ4=:UC1q6ZKsM3i5g0K1PWy5aG
 z21+YGZiaZoNH6Kl67PiacwwAcjpwaMqZ1G3cGQtJixVqzqgFXn4gRtzLRy2KMIbcD+XGoBxZ
 JbZ81NKf/qmRecLd4pVxngra5CDjzb4ltoRr4daXyX4NKDwbYA+9EsPWYhgSUs2g/jso9jUVq
 m/bJXMS7YwZ18eldPN8VJiqlto+QnzECULvQTCsaNWJsgBo7VKSZLaycA24rBN6blBcKsRl1R
 F0tyoH/dEnZl6J/OnyGbxERWy4nx3PuKhP7SAfU9EeNsVHM8DlWB2iWVptMmT5IBW1dfODlh1
 /nY/7Ry1xBPEfriBbAUz77DjOL5sa2VH0d2R2iFYQOjt4Clbob7+EcS+BSskwAGLTLBO3dQCu
 SWW2kcuJBlD8oFgJLxkc5ffQdDPpGIR5L761WZEtGmzso0Ed4M8IfZNtbVjCLp9avaeJWbw2e
 3O+2QiiDY1tGEZrNey9mML53bXM8AWhTZhsfEpybUrpV6e/9jxuUQ1E7j+UEOQK4LzWH4EEiZ
 Bz8B27vIsetVq0Y33N3syQYOxpUE+v0hV/rzqwsJ6OXGtBOmOIFJQ45LVbfL9nMQZmZriMfnE
 3fryiJouRoizhqQkaStVebNmllIqiLMyCLJufLFN7qNFdFsK0uqBi/Ok9XQh8xava6IBm00JS
 e5Tmo3kO7kGHTcV9NhBUKQZLsuZAEjZ6tfO9T7kJoVDuzSA3NHcUdIG6N27+UfSvCXroT76Pl
 BQH5SX/72DVW8u9TQw/NDW2X9kW3Lx/joeDBLJUbYcp4yV1yFI6QItwMpBHbK5Um7oWsLqU7B
 ZTghzKy/qcZ6BT0R6WqcoSkl+SxGYosI2SEo5ijuMKfCAckdUDZmVeIm8Ot9J20d+9r8fgMXY
 hzUeUg3KWMpkd7z8/17g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Jul 2021 16:23:06 +0200 (CEST)
X-Greylist: Delayed for 00:41:04 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 01 Jul 2021 16:23:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Cocci] wireguard project looking for coccinelles to assist
 with Linux->NT conversion (WinDRBD)
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi Jason,

> [ original mail: https://systeme.lip6.fr/pipermail/cocci/2021-July/008661.html ]
> I'm in the midst of doing something potentially a bit taboo in these
> parts: porting some Linux code to the NT kernel used by Windows.

I am the developer of WinDRBD, a project that ports the (Linux)
DRBD (distributed replicated block device) driver from Linux
to the NT-Kernel family. The source code can be found here:

https://github.com/LINBIT/windrbd

Not including work by Mantech we are working since almost
4 years on this port and are approaching a stable 1.0.0 release
(right now I fix things detected by Windows driver verifier).

The approach we use attempts to minimize patches to the original
source code and use a compatibility layer to map the Linux
interfaces (and behaviour) to the Windows NT interfaces (and
behaviour). Since we use Microsoft's C compiler to build the
project we need to patch some compiler specific things (like
MS C does not know gcc's typeof). Parts of the patching is
done via coccinelle but also there are lots of manual patch
files.

My advice would be to keep the compat.h header (and related
files) so that the changes to the Linux sources are kept
at a minimum. The reason for doing so is that it makes it
far more easy to keep in sync with newer wireguard / DRBD
Linux drivers that will come up. (It takes me about 1 to
2 days to upgrade DRBD changes from 1 or 2 months).

The compat layer implements for example a wait_event()
implementation which allows to use Linux wait_event / wake_up
with minimal changes to the original source code (no changes
neccessary if you are using gcc / clang to compile). Also
there is a mapping of the kernel socket API to WinSock.
As long as you are GPL feel free to re-use parts (or the whole)
of the compat layer (I'd be happy to assist you on that process).

> I was wondering if anybody on this list is a bit bored this summer and
> wanted to spend a week or two on this. It's perhaps not the most

I would love to see your project I think and hope we can
collaborate in the future,

Best regards,

- Johannes

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
