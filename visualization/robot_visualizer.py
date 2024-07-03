from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider

def dh_transform(a, alpha, d, theta):
    """
    Compute the Denavit-Hartenberg transformation matrix.
    """
    return np.array([[np.cos(theta), -np.sin(theta) * np.cos(alpha), np.sin(theta) * np.sin(alpha), a * np.cos(theta)],
                     [np.sin(theta), np.cos(theta) * np.cos(alpha), -np.cos(theta) * np.sin(alpha), a * np.sin(theta)],
                     [0, np.sin(alpha), np.cos(alpha), d],
                     [0, 0, 0, 1]])

def plot_frame(ax, T, scale=1.0):
    """
    Plot a coordinate frame (x, y, z arrows) at a given transformation matrix T with a specified scale.
    """
    origin = T[:3, 3]
    x_axis = origin + scale * T[:3, 0]
    y_axis = origin + scale * T[:3, 1]
    z_axis = origin + scale * T[:3, 2]
    
    ax.quiver(*origin, *(x_axis - origin), color='r', length=scale)
    ax.quiver(*origin, *(y_axis - origin), color='g', length=scale)
    ax.quiver(*origin, *(z_axis - origin), color='b', length=scale)

def plot_box(ax, T, width, height, depth):
    """
    Plot a 3D box with specified width, height, and depth at a given transformation matrix T.
    """
    # Define corner points of the box
    corner_points = np.array([[0, 0, 0, 1], [width, 0, 0, 1], [width, depth, 0, 1], [0, depth, 0, 1],
                              [0, 0, height, 1], [width, 0, height, 1], [width, depth, height, 1], [0, depth, height, 1]]).T
    
    # Apply transformation to corner points
    transformed_points = (T @ corner_points)[:3].T

    # Define each face of the box
    faces = [[transformed_points[0], transformed_points[1], transformed_points[3], transformed_points[2]],
             [transformed_points[4], transformed_points[5], transformed_points[7], transformed_points[6]],
             [transformed_points[0], transformed_points[1], transformed_points[4], transformed_points[5]],
             [transformed_points[2], transformed_points[3], transformed_points[6], transformed_points[7]],
             [transformed_points[1], transformed_points[2], transformed_points[5], transformed_points[6]],
             [transformed_points[0], transformed_points[3], transformed_points[4], transformed_points[7]]]

    # Plot each face using plot_surface
    for face in faces:
        x = np.array([point[0] for point in face])
        y = np.array([point[1] for point in face])
        z = np.array([point[2] for point in face])
        ax.plot_surface(x.reshape((2, 2)), y.reshape((2, 2)), z.reshape((2, 2)), color='blue', alpha=0.3)

def plot_cylinder(ax, T, height, radius, color='b'):
    """
    Plot a 3D cylinder with specified height and radius at a given transformation matrix T.
    """
    z = np.linspace(0, height, 100)
    theta = np.linspace(0, 2 * np.pi, 100)
    theta_grid, z_grid = np.meshgrid(theta, z)
    x_grid = radius * np.cos(theta_grid)
    y_grid = radius * np.sin(theta_grid)
    
    for i in range(len(z)):
        for j in range(len(theta)):
            point = np.array([x_grid[i, j], y_grid[i, j], z_grid[i, j], 1])
            transformed_point = T @ point
            x_grid[i, j] = transformed_point[0]
            y_grid[i, j] = transformed_point[1]
            z_grid[i, j] = transformed_point[2]
    
    ax.plot_surface(x_grid, y_grid, z_grid, color=color, alpha=0.3)

def plot_robot(ax, dh_table, joint_values, joint_types):
    """
    Plot the robot in 3D based on DH parameters and joint values.
    """

    # Clear the plot, set limits and add labels
    ax.cla()
    ax.set_xlim([-2, 2])
    ax.set_ylim([-2, 2])
    ax.set_zlim([-2, 2])
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    # ax.set_title('Robot Visualization')

    n_joints = len(joint_values)
    T = np.eye(4)
    points = [T[:3, 3].tolist()]
    plot_frame(ax, T, scale=0.5)
    
    for i in range(n_joints):
        a, alpha, d, theta = dh_table[i]
        if joint_types[i] == 'R':
            theta += joint_values[i]
        elif joint_types[i] == 'P':
            d += joint_values[i]
        
        T = T @ dh_transform(a, alpha, d, theta)
        points.append(T[:3, 3].tolist())
        plot_frame(ax, T, scale=0.5)
        
    points = np.array(points).T
    ax.plot(points[0], points[1], points[2], '-o', markersize=8)

def create_robot_plot(dh_table, joint_types):
    """
    Create an interactive 3D plot with sliders for each joint.
    """
    n_joints = len(joint_types)
    joint_values = [0.0] * n_joints

    fig = plt.figure(figsize=(10, 8))
    ax = fig.add_subplot(111, projection='3d')
    plt.subplots_adjust(left=0.1, bottom=0.25)

    axcolor = 'lightgoldenrodyellow'
    slider_axes = []
    sliders = []
    for i in range(n_joints):
        joint_type = joint_types[i]
        slider_ax = plt.axes([0.1, 0.15 - i * 0.05, 0.8, 0.03], facecolor=axcolor)
        if joint_type == 'R':
            slider = Slider(slider_ax, f'Joint {i+1} ({joint_type})', -np.pi, np.pi, valinit=0)
        elif joint_type == 'P':
            slider = Slider(slider_ax, f'Joint {i+1} ({joint_type})', -1, 1, valinit=0)
        sliders.append(slider)
        slider_axes.append(slider_ax)

    def update(val):
        joint_values = [slider.val for slider in sliders]
        plot_robot(ax, dh_table, joint_values, joint_types)
        fig.canvas.draw_idle()

    for slider in sliders:
        slider.on_changed(update)

    plot_robot(ax, dh_table, joint_values, joint_types)
    plt.show()

"""
# To test the individual plotting functions
def test_individual_plots():
    fig = plt.figure(figsize=(10, 8))
    ax = fig.add_subplot(111, projection='3d')

    # Initial transformation matrix (identity)
    T = np.eye(4)

    # Test plot_frame
    plot_frame(ax, T, scale=0.5)

    # Test plot_box
    T_box = dh_transform(0, 0, 0, 0) @ dh_transform(0, 0, 1, 0)
    plot_box(ax, T_box, width=0.5, height=0.5, depth=0.5)

    # Test plot_cylinder
    T_cylinder = dh_transform(1, 0, 0, 0)
    plot_cylinder(ax, T_cylinder, height=1, radius=0.2)

    ax.set_xlim([-2, 2])
    ax.set_ylim([-2, 2])
    ax.set_zlim([-2, 2])
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    ax.set_title('Test Individual Plots')
    plt.show()

# Create the interactive robot plot
create_robot_plot(dh_table, joint_types)
"""

# Example DH table and joint types
dh_table = [
    [0, np.pi/2, 1, 0],  # Example parameters: [a, alpha, d, theta]
    [1, 0, 0, 0],
    [1, 0, 0, 0]
]

joint_types = ['R', 'R', 'R']  # Example joint types: ['R', 'R', 'R']

# Create the interactive robot plot
create_robot_plot(dh_table, joint_types)
