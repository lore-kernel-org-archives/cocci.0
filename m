Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADA3D43FF5
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=A6G9iuFKHYmazCAUMCCe03MkS7x8jbOYzhLgU1H0kmg=;
  b=MNcZLzKxPw2FHpSDs8QHO3iTR7k9RwtLgGeme0rB/0z98rGRMfpHC6o1
   A1PDU0eQWKIE1HHAydJrYyMm9UXbhwYPyYk0VvpwzONp1YOzEvBsoPUSl
   fpi2JrNWdaPAekgXrZeD7+1RraWGqnPZS5FKJI/sUNUsAq2aoipFDktdf
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="194363593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 10:15:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DA84E0D1E; Mon, 18 Nov 2024 10:14:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C3A2E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 10:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=A6G9iuFKHYmazCAUMCCe03MkS7x8jbOYzhLgU1H0kmg=;
  b=byKbUVOQKZiD49XC4IorlNxxbktMYFCVzbOiWF73Y3qGwLMivXsC/Qmh
   gKq0Nh9JrGxLR3KdGkxrLeqULkS5QGEw7uzwQdO/4dX8551cW8WSgW+7u
   flFG7LEBxCUNxZQUC0wHPB1haP2qrvjHxAzLFAfZDnwLgCNvQXd8723pG
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="194363562"
Received: from lfbn-idf2-1-719-148.w86-247.abo.wanadoo.fr (HELO [192.168.1.35]) ([86.247.169.148])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 10:14:56 +0100
Message-ID: <0676a0b9-81c4-4662-a698-d767ca45148a@inria.fr>
Date: Mon, 18 Nov 2024 10:14:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <e4872a15-ff3d-4619-9b03-c7f0b6230934@stanley.mountain>
 <272B86FC-5CC9-4A3A-ACE0-F268E4E61C3D@inria.fr>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <272B86FC-5CC9-4A3A-ACE0-F268E4E61C3D@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH v2 05/21] powerpc/papr_scm: Convert timeouts to
 secs_to_jiffies()
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2077
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/0676a0b9-81c4-4662-a698-d767ca45148a%40inria.fr>

On 11/16/24 12:24, Julia Lawall wrote:
> Coccinelle tries for 80 chars. It may have a command line option to specify something else.
>
> Julia
There is the option --max-width, which adjusts the line width for 
generated code.  The default is 78.

>> It's kind
>> of a nightmare for an automated script like this to figure out everyone's
>> preferences.  In this particular
>> file, there are some lines which go over 80
>> characters so sure.  Earlier in the patchset one of these introduced a line
>> break that wasn't there before so I think maybe Coccinelle is applying the 80
>> character line break rule?
>>
>> There are sometimes where the 80 character rule really hurts readability, but
>> here it doesn't make any difference.
>>
>> regards,
>> dan carpenter
>>
