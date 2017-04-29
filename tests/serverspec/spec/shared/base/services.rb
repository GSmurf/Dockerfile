shared_examples 'base::services::additional' do
    [
        'cron',
        'dnsmasq',
        'postfix',
        'ssh',
        'syslog-ng'
    ].each do |service|
        describe "service #{service} check" do
            it "should install #{service} daemon" do
                cmd = command("docker-service install #{service}")
                expect(cmd.exit_status).to eq 0
            end

            it "should enable #{service} daemon" do
                cmd = command("docker-service enable #{service}")
                expect(cmd.exit_status).to eq 0
            end

            it "should start #{service} daemon" do
                cmd = command("docker-service start #{service}")
                expect(cmd.exit_status).to eq 0
            end

            it "should have running #{service} daemon", :retry => 5, :retry_wait => 3 do
                cmd = command("docker-service check #{service}")
                expect(cmd.stdout).to match('ok')
                expect(cmd.exit_status).to eq 0
            end
        end
    end
end
