#include <pthread.h>

int global;

static void *thread1(void *x)
{
    global = 42;
    return x;
}

int main()
{
    pthread_t t;
    pthread_create(&t, NULL, thread1, NULL);
    global = 43;
    pthread_join(t, NULL);
    return global;
}
