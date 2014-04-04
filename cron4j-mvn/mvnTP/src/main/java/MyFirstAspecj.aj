public aspect MyFirstAspecj{
    public static final Logger LOGGER = LoggerFactory.getLogger(MyAspectTrace.class);


    private Map<Task, AtomicLong> counters = new HashMap<Task, AtomicLong>();
    private ThreadLocal<AtomicLong> local = new ThreadLocal<AtomicLong>();

    pointcut run(TaskExecutionContext context) : execution(it.sauronsoftware.cron4j.RunnableTask.execute             (TaskExecutionContext context));

    before(TaskExecutionContext context) : run() && args(context){
           Task task = context.getTaskExecutor().getTask();

        // Code using the global map
        AtomicLong count = counters.get(task);
        if (count == null) {
            count = new AtomicLong(0);
            counters.put(task, count);
        }
        long n1 = count.incrementAndGet();

        // Code using the thread local
        count = local.get();
        if (count == null) {
            count = new AtomicLong(0);
            local.set(count);
        }
        long n2 = count.incrementAndGet();
        LOGGER.info("Calling {} - execution #{},{} - thread[{}]", task, n1, n2, Thread.currentThread().getId());
    }

    after(TaskExecutionContext context) : run() && args(context){
        Task task = context.getTaskExecutor().getTask();
        // Cannot be null, it was necessarily set in `before`.
        long n1 = counters.get(task).get();
        long n2 = local.get().get();
        LOGGER.info("End of {}#{},{}", task, n1, n2);
    }
}
