From: michal.kazior@tieto.com (Michal Kazior)
Date: Thu, 6 Oct 2016 16:58:18 +0200
Subject: [Cocci] spatch: dealing with macro calls in structures
Message-ID: <CA+BoTQm9L8vK3Daj+rbWWMVC3dVki9jicdmnHFvp1mjr-=_3=Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I've been struggling to get spatch to parse the following code properly:

struct foo {
        int hello;
        BAR(int) world;
};

int bar(int wut) {
        BAR(int) world;
        return 0;
}

My cocci is:

@@ @@
* struct foo { ... };

@@ @@
* int bar(...) { ... }

If I specify -macro_file which includes:

#define BAR(x)

With v1.0.6 I only get:

-int bar(int wut) {
-       BAR(int) world;
-       return 0;
-}

(i.e. "struct foo" is not recognized)

v1.0.4 gives me nothing.

If I specify -macro_file which includes:

#define BAR(x) x

I get nothing from both 1.0.4 and 1.0.6 except a complaint "try to
delete an expanded token: int".

Is this expected/known?


Micha?
