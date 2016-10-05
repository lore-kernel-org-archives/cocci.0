From: Nikolaus@rath.org (Nikolaus Rath)
Date: Tue, 04 Oct 2016 20:27:56 -0700
Subject: [Cocci] Replacing one (specific!) type with another
Message-ID: <87r37vzd8j.fsf@vostro.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

In a set of C files, I would like to replace each instance of one type
(struct fasel_foo) with another type (struct fasel_bar). For instance,

char* fasel_foo_print(struct fasel_foo *ptr) {
    // ...
   return "this struct fasel_foo string should not change";
}

should become

char* fasel_foo_print(struct fasel_bar *ptr) {
    // ...
   return "this struct fasel_foo string should not change";
}


Based on the LWN articles that I've read, this seems like the perfect
use-case for coccinelle. However, somehow I'm struggling to write a
patch for this. All the documentation that I could get my hands on seems
to describe more abstract changes that require the use of variables -
but as far as I can tell, I need something much simpler:

@@
"struct fasel_foo must be a type name!"
@@
- struct fasel_foo
+ struct fasel_bar


...if only I knew what to put between the @@.

Can someone point me in the right direction?


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
