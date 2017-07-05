From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Jul 2017 20:39:26 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170705162516.jyqinnwnfqjwuskg@eos.mistotebe.net>
References: <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
 <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041858400.11588@hadrien>
 <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
 <20170704174632.v7ibsesdtquktbjs@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041948510.3327@hadrien>
 <WM!afea88a820c9c853667fab8a120e0e62e64bc1c9aacab0e42f4149cedda4906e7b85ddc1f742afe16ea78098b42a61f6!@mailstronghold-3.zmailcloud.com>
 <20170704191736.rcghven7t3ol5ih3@eos.mistotebe.net>
 <alpine.DEB.2.20.1707051420260.3050@hadrien>
 <WM!da212a33f363d5e8666de4eea7afef6ff657b4ba0eea72f6c914a365ab717eec189b136e17bf2c01cc76cdde89f25962!@mailstronghold-2.zmailcloud.com>
 <20170705162516.jyqinnwnfqjwuskg@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707052038150.1974@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Also, the following patch does not actually pick up anything in
> servers/slapd/connection.c, where I would have expected lines 1402
> and 1849 to match. What would be the reason?
>
> @@
> format list[5] five;
> expression E, A1, A2, A3, A4, A5;
> @@
>
> -Statslog( E, "%@five@", A1, A2, A3, A4, A5 );
> +Debug( E, "%@five@", A1, A2, A3, A4, A5 );

Parse error.  For some reason in this file, it decides that NULL is a
typedef.  So most of the file does not parse.  I will look into this.

julia
