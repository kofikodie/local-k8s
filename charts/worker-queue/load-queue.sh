
# Create a work queue called 'keygen'
curl -X PUT localhost:8000/memq/server/queues/keygen

# Create 100 work items and load up the queue.
for i in work-item-{0..99}; do
  curl -X POST localhost:8000/memq/server/queues/keygen/enqueue \
    -d "$i"
done