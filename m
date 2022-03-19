Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A1C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sry6COowFAQl0QKBQ1LdLv5q0dtJmVdPRXbleexQ+GE=;
  b=EbrG7qxZelZbAtMFyjAouRQbLKItpNqF5ugyFpwzmIM9ECM9kDB7Tk45
   BTv7MtfXjJlonGB3P/37fg/tdvKgOtFr5aUupYXOiLZ6Gh8TN4CzFmYpF
   cHLT8CGY2mhji8hzSUxzo5Qoaq/f+EuH8M7ZbZdpZ7wH8f0KK3YTEEVXo
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27017083"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:48:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06BE5E0210; Sat, 19 Mar 2022 18:48:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EB7CCE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:48:44 +0100 (CET)
IronPort-SDR: gu0rA8BIDCmHRi38iBnfppaXhCoLIwyfBkBzFRPF8zcE7oUtk+qUZFsf1ZK0ibT3P1DD1qP0NN
 q0uagnHB7G8fOOJisYlBBnioDP6jnRd4CNpXdgPZEIs2gff8Ew5rbfegSOa7Nqm3zoQiGhdXpB
 ttn6+rFEg4DTcROxXi4Q8lcT4MgQEg0knthKMsp2q0bJ1NHni+UejQZk0qLA/Bt5gvH+nhmZHN
 JRIBCAjvkgJfe1lYj3Et6tScAoqUEbbbQKSiRSyomg70KXDl6xlUsdfEwU9+W5Wfw70NXtUMGa
 XutojXBwVmtOdAWLuhKCQkAt
X-IPAS-Result: =?us-ascii?q?A0B4BgAFFjZi/0Xcza1agQmBWoIoB3dWAQEBKQQLRJNHg?=
 =?us-ascii?q?XeDV5k9gXwLAQMBDS0UBAEBiT0CHQYGMgcOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBgQgsAWMBZwGBTgGBeQYEMA2CNSKELIUUAYMWrgWBM4EBi?=
 =?us-ascii?q?XuBPIYUVodfJxxAgU2BPIURAYJeY4UyBJhiKBSBQzmTYI9cnGiBLoNTBYsKl?=
 =?us-ascii?q?E8GFC6FQpEHkXWWW6FKhTiBPykHLoFZHxQaCCYKgyQJRQECAQIBDAECAgECA?=
 =?us-ascii?q?QIBAgEIAQECAZB9PotRIQEBATE4AgYLAQEDCY0HgkcBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:p5w2WKDLCjQUKBVW/wnlw5YqxClBgxIJ4kV8jS/XYbTApD9202BSx
 jcdCm3UMvuPNDf2ft8iOo2xp0lUvMfXzNc3OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgUlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoweZmNxB+
 JJgjKKtEFstI63Gp+YkaQYNRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcJhGxs250VdRrYT
 /VFNhAwdxXKWAxCBAgMM44El96nuFCqJlW0r3rO+fRssjeDpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zCrD/22si+LLkDm9Xo8OfFGlyhJ0qG+DwWAjOFo7bGWm+KW9l060ZNBmE
 VNBr0LCspMO3ECsS9D8WTixr3iFogMQVrJsLgEq1O2e4vGLvFvBVwDoWhYEOYN27pZnLdA//
 gbRx4uBONB5jFGCpZugGlq8qCP0NDcVIGIGaDVCSwYZizUCnG3RpkmfJjqAOPTp5jEQJd0W6
 2rSxMTZr+xN5fPnL43hoTj6b8uE//Akjmcdv207pF6N4AJjf5KCbIe181Xd5vsoBN/HEgbc4
 iBVypPOt7Fm4XSxeMqlG7ll8FaBvKntDdEhqQQyQfHNCRzyk5JcQWygyGoiehw4bZZslc7Bb
 VDTtA5V6YVSOnDvNfYfXm5CI59C8EUhfPy7Ps3pgi1mOcEgKlXYoHkwOSZ9HQnFySARrE32A
 r/DGe7EMJrQIf0PIOOeS7hP3Lk16Do5wG+PF5n3ww7+geiaZWWJUvEIL1uDY+Q09uWCrRmMq
 4RTMM6DyhN+VuziY3CNrdVJdQ1TcSE2VcLstshaVu+fOQ44SmsvPP/m3u9zcYJSmakIxPzD+
 WuwWxIGxQOn12HHMwiDdltqdKjrAcRktXs+MCF1ZQSo1nEvbJyB9qAac5drL7Ar+PY6naxwT
 uIZYIONHfRCRzDK4XIbYIWk9N5ucxGihASvOSu5YWFlI8U6H1GQpobpJ1K9+jMPAyy7sdoFj
 4ehjg6LE4AeQwlCDdrNbKz9xV2GvU8CxLB4UXzOL4QBY07r6oVrdnL816dlP8EWJBzf7TKGz
 ALKUwwArOzAroJpotnEgaeI89WgH+dkRxcIGnmd4Km2OCTe83Dlx4JcCb7acTfYXWLy2aOje
 eQMla2naqVaxQoTvtouCatvwII/+8Dr+e1QwDNkK2qXPV6lPbVtfyud1s5Vu6wQmLIA4VmqW
 liC88VxMKmSPJ+3C0YYIQcoMraZ2fcPlmWA5Pg5OhyntipnureYUUhfOxSWzipQMOItYo8ix
 O4gvu8Q6hC+00B2aYze03kIrmncfGYdV6gHt40BBNG5gAQcymZdPc7WBBjw7czdcN5LKEQrf
 2GZ3fKQm7RGy0PeWHMvDnyRj/FFjJEDtR0iIIXu/LhVdg4pR8Pb3SG9NRwyXkJY0RVK3uZ+I
 C5tOlEdyWBiOdt3rJArYoxuM1gp6N6lFojZz1oSiHafQlaoW2HJIXd7P+uRlKzcH6SwYRADl
 Ix1Cw/ZvfLCeMDqwjB0VFFlpvHnQMY38ADe8Cxi8wJpALFiCQfYbmSSiabkZvcp7Q7dRKEKm
 AWywNtNVA==
IronPort-HdrOrdr: A9a23:PqGjgKjxLgwnBOzrkvX3gaGnfXBQXsoji2hC6mlwRA09TyX4rb
 HLoBx4vSWatN9/Yh8dcLy7WZVoIkmskKKdg7NhX4tKNTOO0ADEQL2KhrGSoAEIdRefygeD78
 1dT5Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9034553"
X-MGA-submission: =?us-ascii?q?MDHKrqH/qvtD3thrWb4P7moZEskibQdw1YaeH3?=
 =?us-ascii?q?nZ4y//YrTdaCNFvwkbRf99sCioj2755MgtnsLchuh9W5JVGYhOG+6LZS?=
 =?us-ascii?q?IJbjejVEs98YORwvs+szcfGrB92hV7E7qsSij9S2Fk1UxETJi3/sy7Tt?=
 =?us-ascii?q?M9cWaXyANJ1TtM+1I69iROcw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:48:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 6322A41
	for <cocci@inria.fr>; Sat, 19 Mar 2022 10:48:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id e_6tVzYw9usi for <cocci@inria.fr>;
	Sat, 19 Mar 2022 10:48:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id DC95E40
	for <cocci@inria.fr>; Sat, 19 Mar 2022 10:48:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net DC95E40
Date: Sat, 19 Mar 2022 10:48:34 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <b5d854e6-cb4c-cfd6-733a-7adef0b5b37e@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Semantic diff?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 250
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/b5d854e6-cb4c-cfd6-733a-7adef0b5b37e%40ewheeler.net>

Hello all,

Traditional diff would show the following two files very different, but 
Coccinelle understands the syntax so it might be able create a smarter 
diff.

t1.c:
	f(
	){
	}

t2.c:
	f(){}

How does Coccinelle do diffs internally?  Does it parse the whole syntax 
tree and then walk the old and new trees to show the difference when it 
writes patches to stdout?

If so, then perhaps implementing `smpl-diff` would be trivial.  Just load 
two files and compare them with the existing internal diff logic.

Here is the application:

NEC2 was originally written in Fortran and there have been two different 
ports to C from the original Fortran (xec2c and necpp).

The variable and function names are similar (usually exactly identical). 
However, the authors chose different data structures for global values.  
Still, the program flow is almost always the same.

Is there a way to diff two C implementations to see if there are any 
actual differences, not just differences in naming convention?

It seems that it could be possible, Coccinelle has structural awareness 
and understands datatypes.

Then bugs in one program (or the other) caused by author error while 
porting can be detected through such a static analysis. A human could then 
then be compare the C code implementations to the original Fortran to see 
which one is correct, or if the syntactically different representation was 
computationally equivalent.

For example, these two samples compute the same thing but comments, 
floating point notation, and the storage of variables like icon1 and ind1 
differ:

necpp:
     if( -icon1[iprx] != jx )
        ind1=2;
      else
      {
        xi= fabsl( cabj* cab[iprx]+ sabj* sab[iprx]+ salpj* salp[iprx]);
        if( (xi < 0.999999) || (fabsl(bi[iprx]/b-1.) > 1.e-6) )
          ind1=2;
        else
          ind1=0;
      }

xnec2c:
      if( -data.icon1[iprx] != jx )                       
        dataj.ind1=2;                                     
      else                                                
      {                                                   
        xi= fabs( dataj.cabj* data.cab[iprx]+ dataj.sabj* 
            data.sab[iprx]+ dataj.salpj* data.salp[iprx]);
        if( (xi < 0.999999) ||                            
            (fabs(data.bi[iprx]/dataj.b-1.0) > 1.0e-6) )  
          dataj.ind1=2;                                   
        else                                              
          dataj.ind1=0;                                                                                             
      } /* if( -data.icon1[iprx] != jx ) */               


--
Eric Wheeler
