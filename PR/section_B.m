clc, clear, close all
% load data
F0_PVT = load('F0_PVT.mat').PVT
F0_Electrodes = load('F0_Electrodes.mat').Electrodes;

pressure = zeros(6,10);
vibration = zeros(6,10);
temperature = zeros(6,10);

% get data into individual variables
for object = 1:6
    for sample = 1:10
        i = (object-1)*10 + sample;
        pressure(object,sample) = F0_PVT(i).pressure;
        vibration(object,sample) = F0_PVT(i).vibration;
        temperature(object,sample) = F0_PVT(i).temperature;
    end
end

%% Normalize
pressure = normalize(pressure);
vibration = normalize(vibration);
temperature = normalize(temperature);

scatter3(pressure(1,:),vibration(1,:),temperature(1,:),20,'black','filled')
hold on;
scatter3(pressure(2,:),vibration(2,:),temperature(2,:),20,'blue','filled')
scatter3(pressure(3,:),vibration(3,:),temperature(3,:),20,'cyan','filled')
scatter3(pressure(4,:),vibration(4,:),temperature(4,:),20,'green','filled')
scatter3(pressure(5,:),vibration(5,:),temperature(5,:),20,'magenta','filled')
scatter3(pressure(6,:),vibration(6,:),temperature(6,:),20,'red','filled')
legend('Acrylic','Black Foam','Car Sponge','Flour Sack','Kitchen Sponge','Steel Vase', Location='northeast')
set(gcf,'position',get(0,'ScreenSize'))
xlabel('Pressure','Interpreter', 'Latex', 'Fontsize', 14)
ylabel('Vibration','Interpreter', 'Latex', 'Fontsize', 14)
zlabel('Temperature','Interpreter', 'Latex', 'Fontsize', 14)
title(['\textbf{Scatter Plot for PVT at timestep ', num2str(timestep), '}'],'Interpreter', 'Latex', 'Fontsize', 18)
hold off;

%% Covariane matrix - 3x3 - & 

data = zeros(3, 6, 10);    % characteristic x object x sample
data(1,:,:) = pressure;
data(2,:,:) = vibration;
data(3,:,:) = temperature;
data = reshape(data,3,60);

Rxx = data*data'/length(data);
[vectors, ~] = eig(Rxx);
values = eig(Rxx);
[val, order] = sort(values,'descend');

feature_vector = vectors(:, order)

pc1 = feature_vector(:,1)
pc2 = feature_vector(:,2)
pc3 = feature_vector(:,3)


%% Plot
scatter3(pressure(1,:),vibration(1,:),temperature(1,:),20,'black','filled')
hold on;
scatter3(pressure(2,:),vibration(2,:),temperature(2,:),20,'blue','filled')
scatter3(pressure(3,:),vibration(3,:),temperature(3,:),20,'cyan','filled')
scatter3(pressure(4,:),vibration(4,:),temperature(4,:),20,'green','filled')
scatter3(pressure(5,:),vibration(5,:),temperature(5,:),20,'magenta','filled')
scatter3(pressure(6,:),vibration(6,:),temperature(6,:),20,'red','filled')
plot([0,feature_vector(1,1)], [0,feature_vector(2,1)])
plot([0,feature_vector(1,2)], [0,feature_vector(2,2)])
plot([0,feature_vector(1,3)], [0,feature_vector(2,3)])
legend('Acrylic','Black Foam','Car Sponge','Flour Sack','Kitchen Sponge','Steel Vase','PC1','PC2', Location='northeast')
set(gcf,'position',get(0,'ScreenSize'))
xlabel('Pressure','Interpreter', 'Latex', 'Fontsize', 14)
ylabel('Vibration','Interpreter', 'Latex', 'Fontsize', 14)
zlabel('Temperature','Interpreter', 'Latex', 'Fontsize', 14)
title(['\textbf{Scatter Plot for PVT at timestep ', num2str(timestep), '}'],'Interpreter', 'Latex', 'Fontsize', 18)
hold off;

%% Project data onto PC1,2&3
data_new1 = pc1'*data;
data_new1 = reshape(data_new1,6,10).';

data_new2 = pc2'*data;
data_new2 = reshape(data_new2,6,10).';

data_new3 = pc3'*data;
data_new3 = reshape(data_new3,6,10).';

z1 = ones(10,1); 
z2 = zeros(10,1);
z3 = -ones(10,1);

% plot3(data_new(:,1),z,color(1),data_new(:,2),z,color(2),data_new(:,3),z,color(3),data_new(:,4),z,color(4),data_new(:,5),z,color(5),data_new(:,6),z,color(6))
plot(data_new1(:,1), z1, 'k.','MarkerSize',20)
hold on;
plot(data_new1(:,2), z1,'b.','MarkerSize',20)
plot(data_new1(:,3), z1, 'c.','MarkerSize',20)
plot(data_new1(:,4), z1, 'g.','MarkerSize',20)
plot(data_new1(:,5), z1, 'm.','MarkerSize',20)
plot(data_new1(:,6), z1, 'r.','MarkerSize',20)

plot(data_new2(:,1), z2, 'k.','MarkerSize',20)
plot(data_new2(:,2), z2,'b.','MarkerSize',20)
plot(data_new2(:,3), z2, 'c.','MarkerSize',20)
plot(data_new2(:,4), z2, 'g.','MarkerSize',20)
plot(data_new2(:,5), z2, 'm.','MarkerSize',20)
plot(data_new2(:,6), z2, 'r.','MarkerSize',20)

plot(data_new3(:,1), z3, 'k.','MarkerSize',20)
plot(data_new3(:,2), z3,'b.','MarkerSize',20)
plot(data_new3(:,3), z3, 'c.','MarkerSize',20)
plot(data_new3(:,4), z3, 'g.','MarkerSize',20)
plot(data_new3(:,5), z3, 'm.','MarkerSize',20)
plot(data_new3(:,6), z3, 'r.','MarkerSize',20)
grid on;
title("Data distribution across all Principal Components",'FontSize',20)

legend({'Acrylic','Black Foam','Car Sponge','Flour Sack','Kitchen Sponge','Steel Vase'}, 'Location','northeast', 'Fontsize', 14)
set(gcf,'position',get(0,'ScreenSize'))
xlabel('Pressure','Interpreter', 'Latex', 'Fontsize', 14)
ylabel('Vibration','Interpreter', 'Latex', 'Fontsize', 14)
zlabel('Temperature','Interpreter', 'Latex', 'Fontsize', 14)
ylim([-1.5 1.5])
xlim([-3 3])
title(['\textbf{Scatter Plot for PVT at timestep ', num2str(timestep), '}'],'Interpreter', 'Latex', 'Fontsize', 18)
hold off;




























