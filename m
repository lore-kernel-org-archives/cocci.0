Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F3DC433EF
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 20:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=n9fKQMAqZ0uBsLFc7JMWNSOYtmgyuWVgG8qKXl+iiqY=;
  b=XFGSl0a6HiixXQ3hqIyLxuxb+Fnh+6oO5ZkLmozJyWRunN025OIQDQ9I
   RVbIkVjpGL0j3XD30ZhzQTooO1PNECPi4CyOjMQdzd1aPV4kW0erfXxO5
   INlVp4xdN3Rz95ebwODHTIMabsuGkS/jzhZxK/zpPnNs/sZKL05yp4TiM
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="29629875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 22:13:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6833EE033A; Fri,  1 Apr 2022 22:13:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AED5E00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 22:12:59 +0200 (CEST)
IronPort-SDR: ag6RDppoPBKeH2V2s3geF49vGc16KHTSaxQIfbA7HwNEYegrnMuaO4Vn4gHnIfMceUYXFcMgUT
 DV3OnWyG6FFkcTUmcguqrTyOYj986U4BEsP8WaAs4VUVRPXYGjtCpuc0LByCIlCGMz1nILRk+4
 fV8Sdph8kP6XNE16HFdONdsOvW8eHJ5O9mmENbGQGEiwepjWUaAWOAApdVD7dEd8Go3xINx7w9
 cD0oXnBbbMO4HipcVv9W89475o85HSoIZaUBmbQbGJsI31Up5c49sWbg9+cX6rpd++7sV/ZSb9
 Y4sozXLzx34y2oreIQCm6Upe
X-IPAS-Result: =?us-ascii?q?A0BsBQDTW0di/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuCJ?=
 =?us-ascii?q?YMpmUCBfAsBAwENQwQBAYljAh0GBjEIDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEAYEILAFjAWcBgU4BgXkGBD2CNSKELIUUgxewFIEzgQGJfIE8j?=
 =?us-ascii?q?nUcQIFNig+FMgSZR4ECBwxDCXGBOaJKnhyDU59mGi6WUZF9ll6hW4UwgT8jA?=
 =?us-ascii?q?TqBWR8UGggmCjuCak0BAgECAQwBAgIBAgECAQIBCAEBAgGNdAEzFo5OIQEBA?=
 =?us-ascii?q?WkCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:XamWpqi2AqEuCNqK3RTkW3xCX161RRYKZh0ujC45NGQN5FlHY01je
 htvXWnVPKyIMzShedhwYd/g9B9Vu5Ddm4Q3HFRqqnpgE3tjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WGYATNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplv4HublY1OIj2n8cBdR1cOTBGAZQZ0eqSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNa+GP
 JFHNGc0BPjGSyFXYVFJArwcpbu1gFz+LAddk1mcjrVitgA/yyQqjOa2YYWFEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmDO9VZ0SGbC8++QshlCProAONPEIfVGm/97olkibYdV8N
 2oQ/gA/lZQLq2X+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8Lo3uqJOoQXZmUeN4F+5afaURRvh
 wDZxYq4bdB6mOTNESr1y1uCkd+l1cEowYIqYD9CQBQF7tTnrZt1iB/TJjqCLEJXpoalcd0T6
 2rWxMTbu1n0pZRRv5hXBXid31qRSmHhF2bYJmz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 ChbxpHAs7BeUMDleMmxrAMlR+nBCxGta2a0vLKSN8N8qVxBBVb8FWyv3N2ODBw1bJ1VJm+Bj
 L77tBxR6ZJXMWGra6QyO9vZNijZ5fOIKDkkP9iKBudzjm9ZL1TYrHk3NRfPhwgAUiEEyMkCB
 HtSSu70ZV5yNEit5GPeqz413eB5yyYg63nUQJynnR2r3aDHNCyRSKwZKx2DceA04aeJukPT/
 soGb5mGzBBWUevfZCjL8NdJcQtQdSViWcn7+55Na+qOAgt6A2V/WfXf9rMWZNA3lapikOqVr
 Gq2XVVVyQehiCSfexmKcH1qdJjmQY178SAgJSUpMFvxgyojbI+j4b0xbZwyebV7puVvweQtH
 6sBet6cGbJCVTTK9jAQd9/7oZA7LEanggeHPiyEZjkjfsc6G1eTooK9IlLirXBcADC2uM0yp
 6yb+jnaGZdTFR5/CMv2ae60yw3jt3YqmNVtAxnCLO5VdRi+64NtMSHw06E6epleNRXZyzKG/
 A+KGhNE9/LVqoo4/dSV16CJq4ClT7l3EkZARjSJ6KbwODba82enzJUGVuuUJGiPWGTx8aSkR
 ONU0/ClaqFcxg4X6tYlHuY517866vvuu6RekFZuEkLLWEv3WLluFX+LgJtUvapXy74E5wbvA
 hCT+sNXMKmiMd/+FAJDPxIsa+mOiaMOlj/J4ahnKUn2/nYqrr+XF0hNPxSBjCFHar14LNp9k
 +smvccX7S25iwYra4za1XoMqj3Qd3FQAb86spw6AZPwjlR5wF91YavDVn387qaJZogeKUItO
 DKV2fTP3uwO2krYfnMvPnHRxu4B148WsRVHwVJqy45lQTYZaivbHSG98AjbiixQ3lNKzOJ+N
 2xmLQtzKLnmE/KEQiRcdzjEJu2DLETxFo/NJ58hkGzCU1LuW3PNIWA5NPzL+k0Fm46Zkv634
 5nAoFsIkl/WkAXZ2iopRVUjpuPjQNF1+xeEns27dyhA81/WfhK96pKTiaE0R9cLzC//aIArZ
 QWnwQqoVZDGCA==
IronPort-HdrOrdr: A9a23:yyGh1q6IZGy8SMCkbgPXwNjXdLJyesId70hD6qkRc20wTiT7//
 rAoB1173HJYVoqOU3I+urwXZVoI0msl6KdiLN5VdzOMDUO01HYT72Kg7GD/9Q+IUfDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="10336553"
X-MGA-submission: =?us-ascii?q?MDH0wKWqPrxs41UHrYboCJqiiukAvPqZD0xaPr?=
 =?us-ascii?q?eCnC8o9DZqPgUCseOdsZtre6oZduZotd7MFY02NC6v7eMk2V9kV+gF8+?=
 =?us-ascii?q?K3FvcRWSsFLVxBXW8CPoT96y51cx4xbVm7PwPdnwBwadlJQpiMI0LyG1?=
 =?us-ascii?q?vj2IsuyUEDR/xGc+bt1FOxJQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 22:12:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id C77694A
	for <cocci@inria.fr>; Fri,  1 Apr 2022 13:12:55 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yceoXHvpWsXt for <cocci@inria.fr>;
	Fri,  1 Apr 2022 13:12:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id B209340
	for <cocci@inria.fr>; Fri,  1 Apr 2022 13:12:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net B209340
Date: Fri, 1 Apr 2022 13:12:53 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <feae2a17-e570-e92-656b-3562fdaeb720@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Space-delimted string literals
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 327
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/feae2a17-e570-e92-656b-3562fdaeb720%40ewheeler.net>

I think this is a known issue, but thought I would share in case it is 
useful.  This function:

	void print_bug(char *s)               
	{                                     
	    printf(__FILE__ ": BUG: %s\n", s);
	}                                     

is not matched by this SmPL:

	@ p @               
	expression list EL; 
	constant C =~ "BUG";
	@@                  
	-printf(C, EL);     
	+BUG(C, EL);        

but without __FILE__ it matches:

	void print_bug(char *s)               
	{                                     
	    printf(": BUG: %s\n", s);
	}                                     

I've tried to do something like this, but it is invalid SmPL:

	@ p @               
	expression list EL; 
	constant FOO, C =~ "BUG";
	@@                  
	-printf(FOO C, EL);     
	+BUG(C, EL);        

and produces this error:
	minus: parse error: 
	  File "cocci/constant-issue", line 5, column 12, charpos = 68
	  around = 'C',
	  whole content = -printf(FOO C, EL);

This isn't a critical issue in my case, only a few replacements, but 
string literal handling in SmPL might benefit other users.

Consider a grammar like this:

	literal := literal | literal literal

Maybe the definition is a but too recursive, but you can see what I'm 
trying to express.  Maybe keep it as a "constant" or perhaps introduce a 
new SmPL metavar type called "literal" or "string".

Considerations if "a" "b" "c" were being matched:

1. Specify A B C metavars and get the string in each as you would expect.
2. Specify just A and get all of them in A
3. Specify A B and A gets the first and B gets the tail as "b" "c".

Just ideas, I'm open to whatever you think is best for the project.

--
Eric Wheeler
