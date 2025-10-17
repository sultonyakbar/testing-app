LB_URL=$(kubectl get svc p-nodejs-service -n production -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Load 50 requests"
for i in {1..50}; do
    curl -s "http://$LB_URL/" > /dev/null &
    sleep 0.1
done
sleep 20

# Check progress
echo "After load:"
kubectl get hpa -n production
  
echo ""
echo "Load 100 requests"
for i in {1..100}; do
    curl -s "http://$LB_URL/" > /dev/null &
    sleep 0.05
done
sleep 20

# Check progress
echo "After load:"
kubectl get hpa -n production

echo "Load 200 requests"
for i in {1..200}; do
    curl -s "http://$LB_URL/" > /dev/null &
    sleep 0.02
done


echo "⏳ MONITORING SCALING (2 minutes)..."
for i in {1..12}; do
    echo "--- Check $i ---"
    kubectl get hpa -n production
    POD_COUNT=$(kubectl get pods -n production -l app=p-nodejs --no-headers | wc -l)
    echo "Current pods: $POD_COUNT"
    sleep 10
done

echo ""
echo "Results:"
kubectl get hpa -n production
kubectl get pods -n production -l app=p-nodejs
kubectl top pods -n production -l app=p-nodejs

# Show scaling events
echo ""
echo "📋 SCALING EVENTS:"
kubectl describe hpa p-nodejs-hpa -n production | grep -A 20 "Events:"
